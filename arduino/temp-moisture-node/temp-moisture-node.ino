#include <OneWire.h>
#include <DallasTemperature.h>
#include <SPI.h>
#include <RH_RF95.h>

#define DEVICE_ID 1
#define TRANSMIT_INTERVAL 1000
#define ADC_SAMPLES 100
#define ONE_WIRE_BUS 4
#define MOISTURE_PIN A0
#define MOISTURE_PWR_PIN 7
#define RFM95_CS 10
#define RFM95_RST 9
#define RFM95_INT 2
#define RF95_FREQ 915.0


OneWire oneWire(ONE_WIRE_BUS);
DallasTemperature sensors(&oneWire);
RH_RF95 rf95(RFM95_CS, RFM95_INT);

unsigned long lastTransmitTime = 0;
unsigned long transmissionCount = 0;

void setup() {
  Serial.begin(9600);
  delay(3000);
  
  Serial.println(F("==============================="));
  Serial.println(F("Soil Monitor Transmitter v1.0"));
  Serial.println(F("==============================="));
  
  sensors.begin();
  pinMode(RFM95_RST, OUTPUT);
  pinMode(MOISTURE_PWR_PIN, OUTPUT);
  digitalWrite(RFM95_RST, HIGH);
  delay(100);
  digitalWrite(RFM95_RST, LOW);
  delay(10);
  digitalWrite(RFM95_RST, HIGH);
  delay(10);
  
  rf95.init();
  rf95.setFrequency(RF95_FREQ);
  rf95.setTxPower(20, false);
}

float readTemperature() {
  sensors.requestTemperatures();
  delay(750);
  return sensors.getTempCByIndex(0);
}

int readMoisture() {
  digitalWrite(MOISTURE_PWR_PIN, HIGH);
  long sum = 0;
  for (int i = 0; i < ADC_SAMPLES; i++) {
    sum += analogRead(MOISTURE_PIN);
    delay(10);
  }
  digitalWrite(MOISTURE_PWR_PIN, LOW);

  return sum / ADC_SAMPLES;
}

void transmitData(float temp, int moisture) {
  unsigned long uptimeMinutes = millis() / 60000;
  String radiopacket = String(DEVICE_ID) + "," + String(uptimeMinutes) + "," + String(moisture) + "," + String(temp, 1);
  
  Serial.print(F("Transmitting: "));
  Serial.println(radiopacket);
  
  rf95.send((uint8_t *)radiopacket.c_str(), radiopacket.length());
  rf95.waitPacketSent();
  
  Serial.println(F("Transmission successful"));
}

void loop() {
  if (millis() - lastTransmitTime >= TRANSMIT_INTERVAL) {
    Serial.println(F("\n--- New Reading Cycle ---"));
    
    float tempC = readTemperature();
    int moistureRaw = readMoisture();
    
    Serial.print(F("Temperature: "));
    Serial.print(tempC);
    Serial.println(F("°C"));
    
    Serial.print(F("Moisture (raw): "));
    Serial.println(moistureRaw);
    
    int moisturePercent = map(moistureRaw, 0, 1023, 0, 100);
    Serial.print(F("Moisture (approx %): "));
    Serial.println(moisturePercent);
    
    transmissionCount++;
    transmitData(tempC, moistureRaw);
    
    Serial.print(F("Transmission count: "));
    Serial.println(transmissionCount);
    
    lastTransmitTime = millis();
  }
}
