class Criaturas {
  var property salud
  method recibirHechizo(dañoHechizo) { salud = salud - dañoHechizo.daño()}
  method disminuirSalud(cantidad) { salud = salud - cantidad}

 method aumentarSalud(cantidad) { salud = salud + cantidad}
}

object escuela {
  const property estudiantes = #{}
  const property materias = #{}

}

class Estudiantes{
 var property salud
 var property habilidad
 const property hechizosAprendidos = []
 var property hechizoActual
 var property sangrePura
 var property casaHoward


 method peligroso() = if(salud == null) false else casaHoward.peligro(self)

 method cambiarDeCasa(unCasa){ casaHoward = unCasa}

 method recibirDaño(cantidad){ salud = salud - cantidad}

 method anotarseMateria(unMateria) = unMateria.notacion(self)

 method darseDeBaja(unMateria) = unMateria.baja(self)

 method aprenderHechizo(unHechizo) { 
  hechizoActual = unHechizo
  hechizosAprendidos.add(unHechizo)
  }

 method aumentarHabilidad() { habilidad = habilidad + 1}

 method disminuirHabilidad() { habilidad = habilidad - 1}

 method hacerHechizo(alguien,hechizo) { 
  if(!hechizosAprendidos.contains(hechizo) ||  ! hechizo.condicion(self)){
      self.error("no podes lanzar el hechizo")
    }
  
  alguien.recibirHechizo(hechizo)
  hechizo.consecuencia(self)
  }

 method recibirHechizo(hechizoDaño) { salud = salud - hechizoDaño.daño()}

 method disminuirSalud(cantidad) { salud = salud - cantidad}

 method aumentarSalud(cantidad) { salud = salud + cantidad}
}

object gryffindor {
  method peligro(unEstudiante) = false
}

object slytherin {
  method peligro(unEstudiante) = true
}

object ravenclaw  {
  method peligro(unEstudiante) = unEstudiante.habilidad() > 10
}

object hufflepuff {
  method peligro(unEstudiante) = unEstudiante.sangrePura()
}

class Materias {
  const property profesor
  const property alumnos = #{}
  var property hechizo
  method notacion(unEstudiante){
    alumnos.add(unEstudiante)
  }

  method baja(unEstudiante) { alumnos.remove(unEstudiante)}

  method dictarMateria() {
    alumnos.forEach({a=>a.aprenderHechizo(hechizo)})
    alumnos.forEach({a=>a.aumentarHabilidad()})
    }
  
  method practica(criatura){
    alumnos.forEach({ a=>a.hacerHechizo(criatura, hechizo)})
  }

  method cambiarHechizo(unHechizo) { hechizo = unHechizo}
}

class Hechizos {
  var property nivelDificultad
  method condicion(unEstudiante) = unEstudiante.habilidad() > nivelDificultad
}

class HechizosComunes inherits Hechizos {
  method daño() = nivelDificultad + 10
  method consecuencia(unEstudiante) {}
  
}

class HechizosImperdonables inherits Hechizos {
  var property dañoAdicional
  method daño() = (nivelDificultad + 10) * 2
  method consecuencia(unEstudiante) {
    unEstudiante.disminuirSalud(dañoAdicional)
  }

}

class HechizosBuenos inherits Hechizos {
  override method condicion(unEstudiante) = !unEstudiante.peligroso()
  method daño() = nivelDificultad + 10
  method consecuencia(unEstudiante){
    unEstudiante.disminuirHabilidad()
  }
}

