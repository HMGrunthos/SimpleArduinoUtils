//#include <Servo.h>

#define DATAOUT 11  // DIN
#define DATAIN 12   // DOUT
#define SPICLOCK 13 // SCLK
#define CHIPSELECT0 10 // CS_n 0

#define SERVOPIN 7

#define SPISPEED (0x03 & (0))
#define SPISETTINGS ((1<<SPE)|(1<<MSTR)|(0<<CPOL)|(0<<CPHA)|SPISPEED)

//Servo servo;

#define SERVOMIN 1000
#define SERVOMID 1500
#define SERVOMAX 2100


boolean up = false;
unsigned int width = SERVOMID;

void setup()
{
  byte clr;

  Serial1.begin(115200);

  pinMode(DATAIN, INPUT); // SPI
  pinMode(DATAOUT, OUTPUT);
  pinMode(SPICLOCK, OUTPUT);

  pinMode(CHIPSELECT0, OUTPUT); // SPI gyro chip select signal
  digitalWrite(CHIPSELECT0, LOW);

  SPSR = (1<<SPI2X);
  SPCR = (0<<SPIE)|SPISETTINGS;
  clr = SPSR;
  clr = SPDR;

  Serial1.println("Gyro init complete.");

  //servo.attach(SERVOPIN, 585, 2527);
  //servo.write(90);

  //Serial.println("Servo init complete.");

  byte oldSREG = SREG;
  cli();
  TCCR1A = _BV(COM1A1) | _BV(WGM11);
  TCCR1B = _BV(WGM13) | _BV(CS11);
  ICR1 = 15000;
  OCR1A = width;
  SREG = oldSREG;

  pinMode(SERVOPIN, OUTPUT);
}

void loop()
{
  if(up) {
    width += 1;
  } else {
    width -= 1;
  }
  OCR1A = SERVOMIN+550*(sin(2*M_PI*(width-SERVOMIN)/(float)1100)+1);
  Serial1.println(sin(2*M_PI*(width-SERVOMIN)/(float)1100));
  Serial1.println(SERVOMIN+550*(sin(2*M_PI*(width-SERVOMIN)/(float)1100)+1));
  if(width >= SERVOMAX) {
    up = true;
  } else if(width <= SERVOMIN){
    up = true;
  }
  delay(20);
  //servo.write(45);
}
