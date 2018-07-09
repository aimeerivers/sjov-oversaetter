# language: da

Egenskab: Oversæt for sjovt

  Scenarie: Oversæt tekst gennem flere sprog
    Givet filen "start.txt" som er på "Engelsk"
    Når den oversættes gennem folgende sprog:
      | Tysk    |
      | Fransk  |
      | Dansk   |
      | Japansk |
      | Latin   |
      | Swahili |
      | Engelsk |
    Så bliver resultatet gemt i filen "slutning.txt"
