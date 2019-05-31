// Dobrosław Cieślewicz, Grzegorz Maślak, Michał Kolenderski 2019

// Steppers
//
#define X_STEP_PIN         54
#define X_DIR_PIN          55
#define X_ENABLE_PIN       38
#ifndef X_CS_PIN
#define X_CS_PIN         53
#endif

#define Y_STEP_PIN         60
#define Y_DIR_PIN          61
#define Y_ENABLE_PIN       56
#ifndef Y_CS_PIN
#define Y_CS_PIN         49
#endif

#define Z_STEP_PIN         46
#define Z_DIR_PIN          48
#define Z_ENABLE_PIN       62
#ifndef Z_CS_PIN
#define Z_CS_PIN         40
#endif

// Limit Switches
//
#define X_MIN_PIN           3
#ifndef X_MAX_PIN
#define X_MAX_PIN         2
#endif
#define Y_MIN_PIN          14
#define Y_MAX_PIN          15
#define Z_MIN_PIN          18
#define Z_MAX_PIN          19

//message decoding
String msg;
int s1 = 0, s2 = 0, s3 = 0;

bool kier1 = 0, kier2 = 0, kier3 = 0;

bool done = true;  // <------------------------------------------- Matlab

void setup() {
  // put your setup code here, to run once:
  Serial.begin(115200);

  //set enable
  pinMode(X_ENABLE_PIN, OUTPUT);
  digitalWrite(X_ENABLE_PIN, LOW); //negacja ENABLE

  pinMode(Y_ENABLE_PIN, OUTPUT);
  digitalWrite(Y_ENABLE_PIN, LOW); //negacja ENABLE

  pinMode(Z_ENABLE_PIN, OUTPUT);
  digitalWrite(Z_ENABLE_PIN, LOW); //negacja ENABLE


  pinMode(X_DIR_PIN, OUTPUT);
  digitalWrite(X_DIR_PIN, LOW);

  pinMode(Y_DIR_PIN, OUTPUT);
  digitalWrite(Y_DIR_PIN, LOW);

  pinMode(Z_DIR_PIN, OUTPUT);
  digitalWrite(Z_DIR_PIN, LOW);

  //steps
  pinMode(X_STEP_PIN, OUTPUT);
  pinMode(Y_STEP_PIN, OUTPUT);
  pinMode(Z_STEP_PIN, OUTPUT);

  //limit switches setup
  pinMode(X_MAX_PIN, INPUT_PULLUP);
  pinMode(Y_MAX_PIN, INPUT_PULLUP);
  pinMode(Z_MAX_PIN, INPUT_PULLUP);
}

void loop() {

  // -------------- serial read ----------------------
  while (Serial.available() > 0)
  {
    msg = Serial.readStringUntil('\n');
    sscanf(msg.c_str(), "s1 %d s2 %d s3 %d", &s1, &s2, &s3);
    done = false; // <------------------------------------------- Matlab

    kier1 = s1 < 0;
    digitalWrite(X_DIR_PIN, kier1);
    s1 = abs(s1);

    kier2 = s2 < 0;
    digitalWrite(Y_DIR_PIN, kier2);
    s2 = abs(s2);

    kier3 = s3 < 0;
    digitalWrite(Z_DIR_PIN, kier3);
    s3 = abs(s3);

//    Serial.println(s1);
//    Serial.println(s2);
//    Serial.println(s3);
  }

  // -------------------- move/constraints (limit switch) ---------------------------
  if ((kier1 == 1 || (kier1 == 0 && (digitalRead(X_MAX_PIN) == 0))) && s1 > 0)
  {
    digitalWrite(X_STEP_PIN, HIGH);
    s1--;
  }
  
  if ((kier2 == 1 || (kier2 == 0 && (digitalRead(Y_MAX_PIN) == 0))) && s2 > 0)
  {
    digitalWrite(Y_STEP_PIN, HIGH);
    s2--;
  }

  if ((kier3 == 1 || (kier3 == 0 && (digitalRead(Z_MAX_PIN) == 0))) && s3 > 0)
  {
    digitalWrite(Z_STEP_PIN, HIGH);
    s3--;
  }
  delay(1);
  
  digitalWrite(X_STEP_PIN, LOW);
  digitalWrite(Y_STEP_PIN, LOW);
  digitalWrite(Z_STEP_PIN, LOW);
  delay(1);

  // ------------------ Matlab ---------------------------
  // ------------------ steps are equal 0 ----------------
  if(s1 == 0 && s2 == 0 && s3 == 0 && done == false) 
  {
    done = true;
    Serial.println("Success");
  }
  
}
