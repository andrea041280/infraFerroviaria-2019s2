class VagonDePasajeros {
	var property largo
	var property ancho
	var property tieneBanios
	var property estaOrdenado
	
	method cantPasajeros(){ 
		const multiplicador= if (ancho<=3) 8 else 10
		var cantidad= largo * multiplicador
		if (not estaOrdenado) cantidad -= 15
		return cantidad
	}
	method cantMaxCarga(){return  if(tieneBanios) 300 else 800 }
	method pesoMaximo() { return 2000 + 80 * self.cantPasajeros() + self.cantMaxCarga()}
	method hacerMantenimiento(){ estaOrdenado=true }
}

class VagonesDeCarga {
	var property cargaMaximaIdeal
	var property maderaSuelta
	
	method cantMaxCarga(){ return cargaMaximaIdeal - 400 * maderaSuelta}
	method cantPasajeros()=0
	method tieneBanios()=false
	method pesoMaximo(){return  1500+ self.cantMaxCarga()}
	method hacerMantenimiento(){  maderaSuelta= maderaSuelta-2. min(0) }
}

class VagonesDormitorio {
	var property compartimientos
	var property camasPorCompartimiento
	
	method tieneBanios()= true
	method cantPasajeros(){ return compartimientos * camasPorCompartimiento}
	method cantMaxCarga()= 1200
	method pesoMaximo(){ return 4000 + 80 * self.cantPasajeros() + self.cantMaxCarga()}
	method hacerMantenimiento(){}
}

class Formacion{
	const vagones=[]
	
	method pasajeros(){ return vagones.sum({vagon=>vagon.cantPasajeros()})}
	method vagonesPopulares(){return vagones.count({vagon=>vagon.cantPasajeros()>50})}
	method esFormacionCarguera(){ return vagones.all({vagon=>vagon.cantMaxCarga()>1000})}
	method dispersionDePesos(){
		return vagones.max({vagon=>vagon.pesoMaximo()}).pesoMaximo()-vagones.min({vagon=>vagon.pesoMaximo()}).pesoMaximo()
	}
	method baniosFormacion(){ return vagones.count({vagon=>vagon.tieneBanios()})}
	method hacerMantenimiento(){ vagones.forEach({vagon=>vagon.hacerMantenimiento()})}
	method equilibradaEnPasajeros(){return (vagones.max({vagon=>vagon.cantPasajeros().min(0)}).cantPasajeros()-vagones.min({vagon=>vagon.cantPasajeros().min(0)}).cantPasajeros())>20 }
	method estaOrganizada(){
	
		return vagones.sortBy({vagon1,vagon2=>vagon1.cantPasajeros()>= vagon2.cantPasajeros()})
		
	}
}
