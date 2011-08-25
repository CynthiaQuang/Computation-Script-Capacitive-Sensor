int  i;
unsigned int x, y;
float accum, fou, fvalue = .07;    // these are variables for a simple low-pass (smoothing) filter

void setup() {
 Serial.begin(9600);


 pinMode(8, OUTPUT);     // output pin
 pinMode(9, INPUT);      // input pin
 pinMode(13, OUTPUT);
}

void loop() {
 y = 0;        // clear out variables
 x = 0;

 for (i=0; i < 4 ; i++ ){       // do it four times to build up an average - not really neccessary but takes out some jitter

   // LOW-to-HIGH transition
                   
  digitalWrite(8, HIGH);                                  
      // while the sense pin is not high
     while (digitalRead(9) != 1){                  
     x++;
   }
   delay(1);

   //  HIGH-to-LOW transition
           digitalWrite(8, LOW);             
           // while pin is not low  -- same as below only 20 times faster
     while(digitalRead(9) != 0 ) {     // same as above port manipulation - only 20 times slower!
     y++; 
   }

   delay(1);
 }

 fou =  (fvalue * (float)x) + ((1-fvalue) * accum);  // Easy smoothing filter "fval" determines amount of new data in fout
 accum = fou;
if (fou > 90 ){
   digitalWrite(13, HIGH);
   digitalWrite(12, HIGH);
 }else {
   digitalWrite(13, LOW);
   digitalWrite(12, LOW);
 }

 Serial.print( "   ");
 Serial.println( (long)fou, DEC); // Smoothed Low to High
 }
