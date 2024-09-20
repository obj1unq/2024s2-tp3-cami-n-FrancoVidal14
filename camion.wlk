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
		if (not cosas.contains(cosa)) self.error("No esta eso en el camión")
	}
	
	method todoPesoPar() = cosas.all({ cosa => (cosa.peso() % 2) == 0 })
	
	method hayAlgunoQuePesa(peso) = cosas.any({ cosa => cosa.peso() == peso })
	
	method elDeNivel(nivel) = cosas.find(
		{ cosa => cosa.nivelDePeligrosidad() == nivel }
	)
	
	method pesoTotal() = 1000 + cosas.sum({ cosa => cosa.peso() })
	
	method excedidoDePeso() = self.pesoTotal() > 2500
	
	method objetosQueSuperanPeligrosidad(nivel) = cosas.filter(
		{ cosa => cosa.nivelDePeligrosidad() > nivel }
	)
	
	method objetosMasPeligrososQue(cosa) = cosas.filter(
		{ cosa => cosa.nivelDePeligrosidad() > cosa.nivelDePeligrosidad() }
	)
	
	method puedecircularEnRuta(
		nivelMaximoDePeligrosidad
	) = (not self.excedidoDePeso()) && (cosas.count(
		{ cosa => cosa.nivelDePeligrosidad() > nivelMaximoDePeligrosidad }
	) == 0)
	
	method tieneAlgoQuePesaEntre(min, max) = cosas.any(
		{ cosa => (min < cosa.peso()) && (cosa.peso() < max) }
	)
	
	method cosaMasPesada() = cosas.max({ cosa => cosa.peso() })
	
	method pesos() = cosas.map({ cosa => cosa.peso() })
	
	method totalBultos() = cosas.sum({ cosa => cosa.bulto() })
	
	method transportar(destino, camino) {
		self.validarCamion()
		self.validarDestino(destino)
		camino.validarCaminoParaElCamion(self)
		self.descargarLasCosasEn(destino)
	}
	
	method validarDestino(destino) {
		if (destino.espacioParaBultos() < self.totalBultos()) self.error(
				"No hay espacio en el almacen"
			)
	}
	
	method descargarLasCosasEn(destino) {
		destino.cosasDelAlmacen().addAll(cosas)
		cosas.removeAll(cosas)
	}
	
	method validarCamion() {
		if (self.excedidoDePeso()) self.error("El camion esta excedido de peso")
	}
}

object almacen {
	const cosasDelAlmacen = #{}
	var cantidadDeBultosMax = 0
	
	method cantidadDeBultosMax(_cantidadDeBultosMax) {
		cantidadDeBultosMax = _cantidadDeBultosMax
	}
	
	method cantidadDeBultosMax() = cantidadDeBultosMax
	
	method espacioParaBultos() = cantidadDeBultosMax - self.cantidadDeBultos()
	
	method cantidadDeBultos() = if (cosasDelAlmacen.isEmpty()) 0
	                            else cosasDelAlmacen.sum({ cosa => cosa.bulto() })
	
	method agregarCosa(cosa) {
		cosasDelAlmacen.add(cosa)
	}
	
	method cosasDelAlmacen() = cosasDelAlmacen
}

object ruta9 {
	method nivelDePeligrosidad() = 11
	
	method validarCaminoParaElCamion(camion) {
		if (not camion.puedecircularEnRuta(self.nivelDePeligrosidad())) self.error(
				"No puede circular por ruta9, excede la peligrosidad"
			)
	}
}

object caminosVecinales {
	var property pesoMaximoSoportado = 0
	
	method validarCaminoParaElCamion(camion) {
		if (camion.pesoTotal() > self.pesoMaximoSoportado()) self.error(
				"El camino no aguanta el peso"
			)
	}
}