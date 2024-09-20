import cosas.*

object camion {
	const property cosas = #{}
		
	method cargar(unaCosa) {
		unaCosa.consecuencia()
		cosas.add(unaCosa)
	}

	method descargar(cosa) {
	  self.validarCosa(cosa)
	  cosas.remove(cosa)
	}

	method validarCosa(cosa) {
	  if (not (cosas.contains(cosa))) {
		self.error("No esta eso en el camión")
	  }
	}

	method todoPesoPar() {
	  return cosas.all({cosa => cosa.peso() % 2 == 0})
	}

	method hayAlgunoQuePesa(peso) {
	  return cosas.any({cosa => cosa.peso() == peso})
	}

	method elDeNivel(nivel) {
	  return cosas.find({cosa => cosa.nivelDePeligrosidad() == nivel})
	}

	method pesoTotal() {
	  return 1000 + cosas.sum({cosa => cosa.peso()})
	}

	method excedidoDePeso() {
	  return self.pesoTotal() > 2500
	}

	method objetosQueSuperanPeligrosidad(nivel) {
		return cosas.filter({cosa => cosa.nivelDePeligrosidad() > nivel})
	}

	method objetosMasPeligrososQue(cosa) {
	  return cosas.filter({cosa => cosa.nivelDePeligrosidad() > cosa.nivelDePeligrosidad()})
	}

	method puedecircularEnRuta(nivelMaximoDePeligrosidad) {
	  return not(self.excedidoDePeso()) && cosas.count({cosa => cosa.nivelDePeligrosidad() > nivelMaximoDePeligrosidad}) == 0
	}

	method tieneAlgoQuePesaEntre(min, max){
	  return cosas.any({cosa => min < cosa.peso() && cosa.peso() < max })
	}

	method cosaMasPesada() {
	  return cosas.max({cosa => cosa.peso()})
	}

	method pesos() {
	  return cosas.map({cosa => cosa.peso()})
	}

	method totalBultos() {
		return cosas.sum({cosa => cosa.bulto()})
	}

	method transportar(destino, camino) {
		self.validarCamion()
		self.validarDestino(destino)
		camino.validarCaminoParaElCamion(self)
		self.descargarLasCosasEn(destino)
	}
	
	method validarDestino(destino) {
	if (destino.espacioParaBultos() < self.totalBultos()) {self.error("No hay espacio en el almacen")}
	}

	method descargarLasCosasEn(destino) {
	  destino.cosasDelAlmacen().addAll(cosas)
	  cosas.removeAll(cosas)
	}

	method validarCamion() {
	if (self.excedidoDePeso()) {
			self.error("El camion esta excedido de peso")
	}
	}
}


object almacen{
	const cosasDelAlmacen = #{}
	var cantidadDeBultosMax = 0

	method cantidadDeBultosMax(_cantidadDeBultosMax){
		cantidadDeBultosMax = _cantidadDeBultosMax
	}

	method cantidadDeBultosMax() {
	  return cantidadDeBultosMax
	}

	method espacioParaBultos(){
		return cantidadDeBultosMax - self.cantidadDeBultos()
	}

	method cantidadDeBultos() {
	  return if (cosasDelAlmacen.isEmpty())
		0
	  else cosasDelAlmacen.sum{cosa=>cosa.bulto()}
	
	}
	method agregarCosa(cosa) {
	  cosasDelAlmacen.add(cosa)
	}

	method cosasDelAlmacen() {
	  return cosasDelAlmacen
	}
}





object ruta9 {
  method nivelDePeligrosidad(){
	return 11
  }

  method validarCaminoParaElCamion(camion){
		if (not camion.puedecircularEnRuta(self.nivelDePeligrosidad())){self.error("No puede circular por ruta9, excede la peligrosidad")
  }
}
}

object caminosVecinales {
  var property pesoMaximoSoportado = 0 

method validarCaminoParaElCamion(camion){
	if (camion.pesoTotal() > self.pesoMaximoSoportado()){
			self.error("El camino no aguanta el peso")
		}
  }
}
