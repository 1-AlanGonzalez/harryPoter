class Criaturas {
    var property salud
    method recibeDaño(unHechizo) {
        salud = salud - unHechizo
    }
    method aumentarSalud(cantidad){
        salud = salud + cantidad
    }
}

class Estudiantes {
    var property casaHowards
    var property sangrePura
    var property salud
    var property habilidad
    const materias = []
    var hechizoActual = null
    const hechizosAprendidos = []
    method esPeligroso() = if(salud == null) false else casaHowards.peligro(self)
    method hablidad() = habilidad
    method inscribirse(unaMateria) { 
    materias.add(unaMateria)
    unaMateria.alumnos().add(self) 
    }
    method salirse(unaMateria) { 
    materias.remove(unaMateria)
    unaMateria.alumnos().remove(self)
    }
    method aprenderHechizo(unHechizo){
        if(unHechizo.condiciones(self)){
        hechizoActual = unHechizo
        hechizosAprendidos.add(unHechizo)
        habilidad = habilidad + 1
        }
    }
    method ejercitacion(individuo) {
    if (!hechizosAprendidos.contains(hechizoActual) || !hechizoActual.condiciones(self)) {
        throw new Exception(message = hechizoActual.toString() + " no pertenece a los hechizos aprendidos o no cumple con las condiciones")
    }
    hechizoActual.consecuencia(self)
    hechizoActual.dañoDestinatario(individuo)
}

    method consecuenciasDeHechizo(daño){
        salud = salud - daño
    }

    method consecuenciaHechizo(cantidad){
        habilidad = habilidad -1
    }

    method recibeDaño(daño) {
        salud = salud - daño
    }

    method aumentarSalud(cantidad){
        salud = salud + cantidad
    }

}

object gryffindor {
    method peligro(unEstudiante) = false
}

object slytherin {
    method peligro(unEstudiante) = true
}

object revenclaw {
    method peligro(unEstudiante)= unEstudiante.habilidad() > 10
}

object hufflepuf {
    method peligro(unEstudiante) = unEstudiante.sangrePura()
}

class Materias {
    var property profesor
    const property alumnos = []
    var property hechizo
    method enseña() { alumnos.forEach({a=>a.aprenderHechizo(hechizo)})}
    method practica(unaCriatura) { alumnos.forEach({a=>a.ejercitacion(unaCriatura)})}
}

class Hechizos {
    var property nivelDificultad
    method nivelDificultad() = nivelDificultad
    method condiciones(unEstudiante)
    method consecuencia(unEstudiante)
    method dañoDestinatario(individuo)
}

class HechizosComunes inherits Hechizos {
    override method condiciones(unEstudiante) = unEstudiante.habilidad() > self.nivelDificultad()
    override method consecuencia(unEstudiante) { unEstudiante.consecuenciasDeHechizo(0)}
    override method dañoDestinatario(individuo) { individuo.recibeDaño(self.nivelDificultad() + 10)}
}

class HechizosImperdonables inherits Hechizos {
    var property dañoQuienLoHace
    override method condiciones(unEstudiante) = unEstudiante.habilidad() > self.nivelDificultad()
    override method consecuencia(unEstudiante) { unEstudiante.consecuenciasDeHechizo(dañoQuienLoHace)}
    override method dañoDestinatario(individuo) { individuo.recibeDaño(self.nivelDificultad() + 10 * 2)}
}

class HechizosEstudiantesBuenos inherits Hechizos {
    override method condiciones(unEstudiante) = not unEstudiante.esPeligroso()
    override method consecuencia(unEstudiante) {unEstudiante.consecuenciaHechizo(1)}
}