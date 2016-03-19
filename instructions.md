---
title: Laboration 3
       Introduktion till Linux och små nätverk
author:
- name: Anders Jackson
  affiliation: Högskolan i Gävle
  email:
date: 2015-09-28
abstract:
...


Inlämningsuppgift tre
================================================================================

Denna inlämningsuppgift består av tre delar.

* Ni skall titta på hur man kan skapa användare och grupper, samt se hur
  grupper kan användas för att styra vad som får göras i Debian, inte bara
  styra åtkomst av filer.

* Ni skall lära er hur installation och konfiguration av programpaket i Debian
  kan se ut genom att installera och konfigurera två programpaket.

* Ni skall skapa en trädstruktur med kataloger och filer, samt sedan undersöka
  hur rättigheter påverkar hur användare får använda filer och kataloger.


Del ett
--------------------------------------------------------------------------------
Här skall ni se till att programmet `sudo(8)` och att
tidssynkroniseringsprogrammet `ntpd` finns installerat på er maskin.

För att administrera en Linux-maskin så behöver man rättigheter att ändra filer
och kataloger.  Dessa rättigheter har administratörsanvändaren `root`. Den
användaren får göra vad som helst på maskinen. Så den som har tillgång till
lösenordet till `root` kan följdaktligen göra vad som helst på maskinen.

Risken att en hemlighet röjs till obehöriga, som `root`:s lösenord, stiger för
varje person som känner till det. Därför vill man att så få som möjligt behöver
känna till det. Men man kan fortfarande vilja att fler än en användare skall
kunna administrera maskinen. Så, hur löser man detta utan att de får tillgång
till lösenordet?

Jo, det finns ett program som heter `sudo`, som tillåter att vissa godkända
användare kan utföra kommandon som någon annan användare, som exempelvis
användaren `root`. Detta är bra, eftersom då behöver inte någon känna till
lösenordet till användaren `root`. men kan fortfarande utföra kommandon som
användaren `root`. Detta leder då till att risken att lösenordet för `root`
kommer på villovägar minimeras. En annan fördel är att man i efterhand kan se
vad olika användare har gjort. Tredje fördelen är att man kan hindra `root`
från att logga in över huvud taget, så de som eventuellt vill försöka bryta sig
in i maskinen har ett konto mindre som de kan ta sig in med.  Ett till problem
som vi skall lösa i laborationen är att se till att alla maskiner i nätverket
har samma tid.

Om datorer har olika tid, så kan man inte jämföra loggar mellan maskiner för
att återskapa i vilken ordning saker hände, exempelvis vid intrångsförsök. Om
en dator delar med sig av filer över nätverket, så kan det bli konstigt om en
fil ändras i en servern och sedan tittar klienten på filen. Om du klockorna går
olika hos servern och klienten, så kan det innebära att det ser ut som om filen
ändrats i framtiden. Detta kan medföra problem med vissa program som tittar på
när en fil skapats/ändrats.  För att lösa detta så behöver tiden synkroniseras
mellan dessa datorer och detta kan göras med programmet ntp. Därför vill vi
installera det på vår linuxdator. Detta program kan synkronisera datorer mot
ett atomur över internet med protokollet NTP så att klockorna går på
hundradelar när lika.

För att utföra dessa laborationer så behöver ni använda kommandot
`aptitude(8)`1 med argumenten search, show och install. Ni kan även använda
kommandon `apt-get(8)`, `dpkg(8`) med argumentet `-S` för att lösa uppgiften.

När ett paket är installerat, så finns det några ställen som man bör titta
efter mer information om hur paketet konfigureras normalt och hur man kan ändra
standardinställningarna. Så om vi installerar paketet **`PAKET`**, så hittar vi
information i katalogen `/usr/share/doc/**PAKET**/` i minst filerna
`README.Debian` och `NEWS.Debian.gz`, där filer som slutar på `.gz` är
komprimerade. Läs översiktligt genom dem för att få en känsla av vad som
paketet kan göra. Lämpliga program att läsa dessa filer med kan vara `more(1)`
och `zmore(1)`. Kommandot `zmore` avkomprimerar den fil som visas, så det
behövs inte göras explicit med `gunzip(1)`. Eventuella andra filer i katalogen
kan vara intressant, så titta i dem. Vissa paket har inställningar i filen
`/etc/default/**PAKET**`.  Dessa brukar ha gott om kommentarer och även vara
värda att titta i för att exempelvis se hur man skall starta en server eller
andra inställningar.

För mer information om ett program/paket så kan man som vanligt använda
`man(1)` men man kan även söka på webbsidan <http://wiki.debian.org/>.
Där hittar man rätt mycket intressant information.


Installera `sudo`
--------------------------------------------------------------------------------
För att få tillgång till kommandot `sudo`, så behöver rätt paket installeras.
Kommandon finns normalt i katalogerna `/bin/` och `/usr/bin/`. Så leta reda på
vilket paket som innehåller kommandot `sudo` och installera detta paket, om det
inte redan är installerat. Många konfigurationsfiler till kommandon finns under
katalogen `/etc/`, så det är alltid en bra idé att titta där, förutom i de
andra ställena. Där hittar ni konfigurationsfilen till `sudo` som talar om
vilka användare och grupper av användare som får använda kommandot `sudo`. För
att veta vilken fil det är och hur den fungerar, sök efter `sudo` i Debians
wiki-dokumentation eller i manualsidan för `sudo`.


Installera ntp
--------------------------------------------------------------------------------
Debian-paketet `ntp` innehåller programvaran för att synkronisera tiden mellan
olika datorer. För att det skall fungera bra, så behöver klockorna ställas in
när maskinen startar om. För om klockan går för mycket fel, så kan inte `ntp`
ställa klockan. Därför behöver vi även programmet `ntpdate`, som sätter klockan
när datorn startar. Det finns ett antal atomur som man kommer åt via internet.
Vilka det är kan man se på webbsidan i punkt två nedan.

1) Installera programmen `ntpdate` och `ntp`.

2) Konfigurera dem så att de använder samma atomur-server på internet från
   ntp-pool-projektet, exempelvis <1.debian.pool.ntp.org> och
   <2.debian.pool.ntp.org> eller <1.se.pool.ntp.org> och <2.se.pool.ntp.org>.
   Se <http://www.pool.ntp.org/>.

3) Redovisa i en rapport vilka kommandon ni använt, vilka filer ni har ändrat
   och varför ni har ändrat dem.


Del två
--------------------------------------------------------------------------------
I den här uppgiften skall ni skapa en användare samt se till att användaren kan
använda kommandot `sudo` som ni installerade ovan. Debians `sudo`-paket är
inställt på att kontrollera om användaren hör till en speciell grupp, för att
veta om de får använda kommandot `sudo` eller ej. Ni skall använda de kommandon
som man normalt använder i Debian för att skapa användare och lägga till en
grupp till en användare.

Kommandon som ni skall använda är `adduser(1)` och `addgroup(1)` samt en
editor, exempelvis `nano`(1). Ni skall alltså inte ändra direkt i filerna
`/etc/passwd`, `/etc/shadow` eller `/etc/group`. Men ni kan med fördel titta i
dem vad som händer när ni använder kommandona.

När ni skapat användaren så skall ni logga in i den nya användaren och
demonstrera att ni från den användaren kan köra kommandon som användaren
`root`.

För att se vilka grupper en användare hör till, så kan ni med fördel använda
kommandona `id(1)`, `whoami(1)` och `groups(1)`.

Redovisa genom att skriva de kommandon som behövs i ett skalprogram och en
avbild av skärmen.  Ni kan få den antingen genom att göra en skärmdump i
grafisk miljö eller genom att använda programmet `script(1)`. Exempelvis kan
man skriva script `loggfil.txt`. Då kommer allt som ni skriver in och allt som
skrivs ut av kommandon som sedan körs att sparas i filen `loggfil.txt`, tills
ni avslutar med `exit` eller `Ctrl-D`. Kör inte fullskärmseditor i `script`,
kör det i ett annat fönster.


Del tre
--------------------------------------------------------------------------------
Slutligen skall vi i den här uppgiften prova hur rättigheterna för användare
fungerar, och specifikt då för den användare som skapades i del två ovan. Så
kom ihåg vad ni döper er användare till.

Börja med att logga in som den användare nu skapade i del två och från den
användaren skapa katalogstrukturen och filerna enligt nedan:

+----------------+-----------------+-------------------------+--------------------------------+
| **Filväg**     | **Rättigheter** | **Ägare**               | **Grupp**                      |
+================+=================+=========================+================================+
| `/tmp/del3`    | `drwxr-xr-x`    | Användaren från del två | Gruppen som användaren tillhör |
| `/tmp/del3/a1` | `drwx------`    | `root`                  | Gruppen som användaren tillhör |
| `/tmp/del3/a2` | `-rwxr--r--`    | Användaren från del två | `root`                         |
| `/tmp/del3/a3` | `drwxr--r--`    | Användaren från del två | Gruppen som användaren tillhör |
| `/tmp/del3/a4` | `-rwxrwx---`    | `root`                  | `root`                         |
+----------------+-----------------+-------------------------+--------------------------------+

Exekvera sedan kommandona nedan i given ordning som användaren som ni skapade i
del två.  Om ni är osäkra på kommandona, så läs manualsidan med
`man(1)`-kommandot samt prova gärna dem var för sig.

* ```bash
  touch /tmp/del3/a1/f1`
  ```

* ```bash
  sudo touch /tmp/del3/a3/f1`
  ```

* ```bash
  sudo echo ”Hello World” | tee /tmp/del3/a3/f1`
  ```

* ```bash
  sudo echo ”Hello World” | tee /tmp/del3/a2`
  ```

* ```bash
  sudo echo ”Hello World” | tee /tmp/del3/a4`
  ```

* ```bash
  cat /tmp/del3/a2`
  ```

* ```bash
  sudo cat /tmp/del3/a2`
  ```

* ```bash
  cat /tmp/del3/a4`
  ```

* ```bash
  sudo cat /tmp/del3/a4`
  ```

* ```bash
  echo ”Goodbye World” | sudo tee /tmp/del3/a2`
  ```

* ```bash
  cat /tmp/del3/a2`
  ```

* ```bash
  sudo cat /tmp/del3/a2`
  ```

* ```bash
  sudo rm -r /tmp/del3/ # Observera att det är /tmp`
  ```

Redovisa genom att skriva de kommandon som ni använder för att skapa
katalogerna, filerna samt sätter rättigheterna. Förklara vad varje kommandorad
gör, varför det händer samt vilken användare som utför delkommandon (som
exempelvis `sudo tee /tmp/del3/a2`). Några av kommandonen kommer att ge
felmeddelanden, så då behöver ni förklara varför detta sker. Katalogstrukturen
redovisas lämpligen med kommandot `tree(1)` med växeln `-a`.


Rapporten
--------------------------------------------------------------------------------
Den rapport som ni skriver skall innehålla ett försättsblad som innehåller
laborationens namn, datum, ert namn, födelsedatum/personnummer samt
datorpostadress (på högskolan).  Rapporten skall vara skriven så att jag kan
förstå att ni förstått samt ser vad ni gjort. Ingen roman behövs dock. Det
borde räcka med 4-7 sidor totalt med text som den här laborationsunderlaget.
Följande delar/rubriker kan vara bra att ha i rapporten.

1. Försättsblad
2. Innehållsförteckning
3. Inledning: Ni beskriver problemet och vilka frågor som skall besvaras
4. Genomförande: Här beskriver ni hur ni har löst laborationen
5. Slutsatser: Här beskriver ni svaren på frågorna i Inledning:en
6. Övrigt: Om ni vill lägga till något som inte får plats i Slutsatser
7. Referenser: Så att vi ser vart ni hämtat er information för genomförandet
8. Bilagor: Här lägger ni stora bilder och programlistningar

Rapporten, i PDF-format och inget annat, samt eventuella andra text- och
data-filer som behövs för att rapporter lägger ni i en katalog samt använd
programmet tar eller gzip för att skapa ett arkiv som ni skickar in i
BlackBoard. Dvs så här kan ni göra för att skapa arkivfilen för inskickning.
Byt ut mitt-namn mot ert egna namn. :-)

```bash
$ mkdir ~/laboration2-mitt-namn
$ cp rapport-lab2.pdf ~/laboration2-mitt-namn
$ cp textfil.txt ~/laboration2-mitt-namn
$ tar -cvf ~/laboration2-mitt-namn.tar ~/laboration2-mitt-namn
```

Nu har ni det som behövs i `laboration2-mitt-namn.tar`, klart!

OM ni bara skickar in PDF-format, så behöver ni inte skapa ett tar-arkiv för
laborationen utan kan skicka in rapporten direkt.


Om uppgiften och forum
--------------------------------------------------------------------------------
Om ni får problem, så ställ frågor i forumet som finns i BlackBoard. Att lära
sig att administrera datorer handlar om att i forum kunna ställa rätt frågor,
så det kan ni gärna öva på här.  När ni ställer en fråga, så skall ni beskriva
vad ni vill göra, vad ni har gjort samt vad ni förväntat er skall ske samt vad
som skett. Om ni beskriver för dåligt, så kommer ni att få frågor om mer
information. Tänk på att de som läser era frågor inte har sett vad ni gjort, så
det är ert ansvar att förklara så att de andra förstår ert problem och kan
besvara frågan.  Ni får även gärna svara på frågor i BlackBoard, där
medstudenter förklarat vad de försökt med och vad som inte gått som de tänkt.
Begär mer information om ni inte har fått tillräckligt med inform- ation så att
ni förstått vad som frågats efter. Samt i den här kursen så begär att få veta
vad de som ställer frågan har gjort innan ni svarar.


Lycka till!
Anders Jackson


Referenser
--------------------------------------------------------------------------------

### Debian paketinformation
<http://wiki.debian.org/> (Debians officiella Wiki-dokumentation)  
<http://www.debian.org/distrib/packages> (Databas över Debian-paket)  
<http://www.debian-administration.org/> (Wiki-dokumentation för administratörer)  

### Net Time Protocol
<http://www.sp.se/sv/index/services/time_sync/ntp/sidor/default.aspx> (Svenska standardtiden)  
<http://sv.wikipedia.org/wiki/Network_Time_Protocol> (Kort beskrivning av NTP-protokollet)  
<http://en.wikipedia.org/wiki/NTP_pool> (NTP-servrar på internet)  
<http://www.pool.ntp.org/sv/> (Svenska NTP-servrar)  
%
