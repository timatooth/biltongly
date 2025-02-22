#include <SPI.h>
#include <RH_RF95.h>

RH_RF95 rf95;

int led = 8;

void setup() 
{
  pinMode(10, OUTPUT);
  digitalWrite(10, HIGH);

  pinMode(led, OUTPUT);     
  Serial.begin(9600);
  while (!Serial) ; // Wait for serial port to be available
  if (!rf95.init())
    Serial.println("INIT: failed");
  else 
    Serial.println("INIT: success");
    
  rf95.setFrequency(915.0);
  // Defaults after init are 434.0MHz, 13dBm, Bw = 125 kHz, Cr = 4/5, Sf = 128chips/symbol, CRC on

  // You can change the modulation parameters with eg
  // rf95.setModemConfig(RH_RF95::Bw500Cr45Sf128);

  // The default transmitter power is 13dBm, using PA_BOOST.
  // If you are using RFM95/96/97/98 modules which uses the PA_BOOST transmitter pin, then 
  // you can set transmitter powers from 2 to 20 dBm:
  //  driver.setTxPower(20, false);
  // If you are using Modtronix inAir4 or inAir9, or any other module which uses the
  // transmitter RFO pins and not the PA_BOOST pins
  // then you can configure the power transmitter power for 0 to 15 dBm and with useRFO true. 
  // Failure to do that will result in extremely low transmit powers.
  //driver.setTxPower(14, true);
}

void loop()
{
  if (rf95.available())
  {
    uint8_t buf[50];
    uint8_t len = sizeof(buf);

    if (rf95.recv(buf, &len))
    {
      digitalWrite(led, HIGH);

      // Ensure the buffer is null-terminated
      buf[len] = '\0';  

      Serial.print("RX: ");
      Serial.print((char*)buf);

      Serial.print(",");
      Serial.println(rf95.lastRssi());

      digitalWrite(led, LOW);
    }
    else
    {
      Serial.println("Receive failed");
    }
  }
}
