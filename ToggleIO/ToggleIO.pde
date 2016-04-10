#define DATA0 13
#define DATA1 12
#define DATA2 11
#define DATA3 10
#define DATA4 9

boolean pinVal[5] = {false, false, false, false, false};

void setup()
{
  Serial.begin(115200);

  pinMode(DATA0, OUTPUT);
  pinMode(DATA1, OUTPUT);
  pinMode(DATA2, OUTPUT);
  pinMode(DATA3, OUTPUT);
  pinMode(DATA4, OUTPUT);
  digitalWrite(DATA0, LOW);
  digitalWrite(DATA1, LOW);
  digitalWrite(DATA2, LOW);
  digitalWrite(DATA3, LOW);
  digitalWrite(DATA4, LOW);

  Serial.println("Init complete.");
}

void loop()
{
  if(Serial.available()) {
    int val = Serial.read() - '0';
    if(val >= 0 && val <= 4) {
      pinVal[val] = !pinVal[val];
    }
    switch(val) {
      case 0:
          digitalWrite(DATA0, pinVal[val]?HIGH:LOW);
        break;
      case 1:
          digitalWrite(DATA1, pinVal[val]?HIGH:LOW);
        break;
      case 2:
          digitalWrite(DATA2, pinVal[val]?HIGH:LOW);
        break;
      case 3:
          digitalWrite(DATA3, pinVal[val]?HIGH:LOW);
        break;
      case 4:
          digitalWrite(DATA4, pinVal[val]?HIGH:LOW);
        break;
    }
  }
}
