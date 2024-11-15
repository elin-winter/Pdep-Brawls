import mision.*

class Personaje {
  var cantCopasGanadas

  method sumarCopas(cant) {
    cantCopasGanadas += cant
  }

  method cantCopasGanadas() = cantCopasGanadas

  method destreza()
  method tieneEstrategia()
}

class Arquero inherits Personaje {
  const agilidad
  const rango

  override method destreza() = agilidad * rango
  override method tieneEstrategia() = rango > 100
}

class Guerrera inherits Personaje {
  const tieneEstrategia
  const fuerza

  override method tieneEstrategia() = tieneEstrategia
  override method destreza() = 1.5 * fuerza
}

class Ballestero inherits Arquero {
  override method destreza() = super() * 2
}

