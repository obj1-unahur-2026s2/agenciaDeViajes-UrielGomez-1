class PackDeViaje{
    const diasDeViaje
    const precioBase
    const beneficios
    const cordinador
    method diasDeViaje() = diasDeViaje
    method precioBase() = precioBase
    method beneficios() = beneficios
    method cordinador() = cordinador
    method costoBeneficiosVigentes() = beneficios.filter { beneficio => beneficio.estaVigente() }.sum { beneficio => beneficio.precio() }
    method precioFinal()
    method esPackPremium()
}
class PackNacional inherits PackDeViaje {
    const provinciaADestino
    method provinciaADestino(){
        return provinciaADestino
    }
    method actividades(){
        return provinciaADestino.actividades()
    }
    override method precioFinal(){
    return precioBase + self.costoBeneficiosVigentes()
    }
    override method esPackPremium(){
        return diasDeViaje > 10 && cordinador.esAltamenteCalificado()
    }
}
class PackInternacional inherits PackDeViaje {
    const provinciaADestino
     method provinciaADestino(){
        return provinciaADestino.nombreDelPais()
    }
    method actividades(){
        return provinciaADestino.actividades()
    }
    method cantidadDeEscalas(){
        return provinciaADestino.cantidadDeEscalas()
    }
    method esLugarDeInteresTuristico(){
        return provinciaADestino.esLugarDeInteresTuristico()
    }
    override method precioFinal(){
    return (precioBase + self.costoBeneficiosVigentes()) * 1.20
    }
    override method esPackPremium(){
        return diasDeViaje > 20 && provinciaADestino.esLugarDeInteresTuristico() && provinciaADestino.cantidadDeEscalas() == 0
    }
}
class PackProvinciales inherits PackNacional {
    const cantidadDeCiudadesAVisitar
    method cantidadDeCiudadesAVisitar() = cantidadDeCiudadesAVisitar
    override method esPackPremium(){
        return provinciaADestino.actividades().size() >= 4 and cantidadDeCiudadesAVisitar > 5 and beneficios.filter { beneficio => beneficio.estaVigente() }.size() >= 3
    }
    override method precioFinal(){
        if (self.esPackPremium()) {
            return super() * 1.05
        } else {
            return super()
        }
    }
}
class Pais{
    const nombre
    const actividades =["Senderismo", "Visitas culturales", "Gastronomía local"]
    const cantidadDeEscalas
    const esLugarDeInteresTuristico
    method nombreDelPais() = nombre
    method actividades() = actividades
    method cantidadDeEscalas() = cantidadDeEscalas
    method esLugarDeInteresTuristico() = esLugarDeInteresTuristico
}
class Cordinador{
    const cantidadDeViajesRealizados
    const estaMotivado
    const aniosDeExperiencia
    const rolesValidos = ["Guía", "Asistente logístico", "Acompañante"]
    var rol = "Guía"
    method cantidadDeViajesRealizados() = cantidadDeViajesRealizados
    method estaMotivado() = estaMotivado
    method aniosDeExperiencia() = aniosDeExperiencia
    method rol() = rol
    method asignarRol(nuevoRol){
        if (!rolesValidos.contains(nuevoRol)) {
            throw new Exception(message = "El rol asignado no es válido")
        }
        rol = nuevoRol
    }
    method esAltamenteCalificado(){
        return self.cantidadDeViajesRealizados() > 20 && self.cumpleSuRol()
    }
    method cumpleSuRol(){
        if (rol == "Guía") {
            return self.estaMotivado()
        } else if (rol == "Asistente logístico") {
            return self.aniosDeExperiencia() >= 3
        } else {
            return true
        }
    }
}
class Beneficios{
    const tipoDeBeneficio
    const precio
    const estaVigente
    method tipoDeBeneficio() = tipoDeBeneficio
    method tipoDeBneficio() = self.tipoDeBeneficio()
    method precio() = precio
    method estaVigente() = estaVigente
}