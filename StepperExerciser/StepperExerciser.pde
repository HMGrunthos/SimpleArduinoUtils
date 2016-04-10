#define stepPin 4
#define dirPin 5
#define ledPin 13

#define MAXSPEED 750
#define MINSPEED 4000
#define MINSPEEDDELTA 300

#define MAXDURATION 1900
#define MINDURATION 200

#define MICROSTEPPING 0

static unsigned int inital = 0;

static void initialExerciser();

void setup()
{
  Serial.begin(9600);
  Serial.println("Starting stepper exerciser.");

  pinMode(stepPin, OUTPUT);
  pinMode(dirPin, OUTPUT);
  pinMode(ledPin, OUTPUT);

  digitalWrite(dirPin, HIGH);
  digitalWrite(stepPin, LOW);
  digitalWrite(ledPin, LOW);

  delay(2000);

  digitalWrite(ledPin, HIGH);
}

void loop()
{
  int duration, speed, oldSpeed;
  
  if(inital++ == 0) {
    Serial.println("Initial exerciser.");
    initialExerciser();
    return;
  } else {
    Serial.println("Random exerciser.");
  }

  oldSpeed = speed = 750;

  for (int i=0; i<10; i++) {
    duration = random(MINDURATION, MAXDURATION);

    while(abs(oldSpeed-speed) < MINSPEEDDELTA) {
      speed = random(MAXSPEED, MINSPEED);
      Serial.println("Rolled dice for speed.");
    }
    oldSpeed = speed;

    Serial.print("Speed: ");
    Serial.println(speed);
    Serial.print("Duration: ");
    Serial.println(duration);

    digitalWrite(ledPin, HIGH);   // sets the LED on
    for (int j=0; j<duration; j++) {
      digitalWrite(stepPin, HIGH);
      delayMicroseconds(2);
      digitalWrite(stepPin, LOW);
      delayMicroseconds(speed << MICROSTEPPING);
    }
    digitalWrite(ledPin, LOW);    // sets the LED off

    delay(500);
    Serial.println("Switching directions.");
    digitalWrite(dirPin, !digitalRead(dirPin));

    digitalWrite(ledPin, HIGH);    // sets the LED on
    for (int j=0; j<duration; j++) {
      digitalWrite(stepPin, HIGH);
      delayMicroseconds(2);
      digitalWrite(stepPin, LOW);
      delayMicroseconds(speed << MICROSTEPPING);
    }
    digitalWrite(ledPin, LOW);    // sets the LED off

    delay(1000);
    Serial.println("Switching directions.");
    digitalWrite(dirPin, !digitalRead(dirPin));
  }
}

static void initialExerciser()
{
  // digitalWrite(ledPin, HIGH);    // sets the LED on

  for (int j=0; j<10; j++) {
    Serial.println("Step.");
    digitalWrite(stepPin, HIGH);
    delayMicroseconds(2);
    digitalWrite(stepPin, LOW);
    delay(400);
  }

  Serial.println("Switching directions.");
  digitalWrite(dirPin, !digitalRead(dirPin));

  for (int j=0; j<10; j++) {
    Serial.println("Step.");
    digitalWrite(stepPin, HIGH);
    delayMicroseconds(2);
    digitalWrite(stepPin, LOW);
    delay(400);
  }

  // digitalWrite(ledPin, LOW);    // sets the LED off
}
