import personaje.*

// ------------------------- Superclase

class Mision {

    const formaDePremiar
    const participantes
    
    method participantes() = participantes

    method realizarMision(personaje) {
        if(self.sePuedeRealizar()) {
            var cant = self.cantCopasEnJuego()
            if(self.esSuperada())  
                cant = formaDePremiar.cantCopasFinal(self) 
            else cant *= -1

            personaje.sumarCopas(cant)
        } else 
            throw new DomainException(message = "Misión no puede comenzar")
    }

    method esSuperada() = 
        self.mayoriaEstrategas() || self.partipantesDiestros()

    method mayoriaEstrategas() = 
        participantes.filter({x => x.tieneEstrategia()}) > (participantes.size() / 2)

    method partipantesDiestros()
    method sePuedeRealizar()
    method cantCopasEnJuego()

}

// ------------------------- Subclases

class MisionIndividual inherits Mision {
    const dificultad
    const participante = participantes.head()

    override method sePuedeRealizar() = participante.cantCopasGanadas() > 10
    override method cantCopasEnJuego() = 2 * dificultad
    override method partipantesDiestros() = participante.destreza() > dificultad

}

class MisionEquipo inherits Mision {
    
    override method sePuedeRealizar() = 
        participantes.map({x => x.cantCopasGanadas()}).sum() > 60
    
    override method cantCopasEnJuego() = 50 / participantes.size()
    
    override method esSuperada() = 
        self.mayoriaEstrategas() || self.partipantesDiestros()
    
    override method partipantesDiestros() = 
        participantes.all({x => x.destreza() > 400})
}

// ------------------------- Tipos de Misiones

object normal {
    method cantCopasFinal(mision) = mision.cantCopasEnJuego()
}

class Boost {
    const multiplicador
    method cantCopasFinal(mision) = 
        mision.cantCopasEnJuego() * multiplicador
}

object bonus {
    method cantCopasFinal(mision) = 
        mision.cantCopasEnJuego() + mision.participantes().size()
}