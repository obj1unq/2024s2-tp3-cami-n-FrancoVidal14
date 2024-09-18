import cosas.*

object camion {
	const property cosas = #{}
		
	method cargar(unaCosa) {
		cosas.add(unaCosa)
	}

	method descargar(cosa) {
	  cosas.remove(cosa)
	}

	method todoPesoPar() {
	  return cosas.all({cosa => cosa.peso() % 2 == 0})
	}

	method hayAlgunoQuePesa(peso) {
	  return cosas.any({cosa => cosa.peso() == peso})
	}

	method elDeNivel(nivel) {
	  return cosas.find({cosa => cosa.nivel() == nivel})
	}

	method pesoTotal() {
	  return 1000 + cosas.sum({cosa => cosa.peso()})
	}

	method excedidoDePeso() {
	  return self.pesoTotal() > 2500
	}

	method objetosQueSuperanPeligrosidad(nivel) {
		return cosas.filter({cosa => cosa.nivelPeligrosidad() > nivel})
	}

	method objetosMasPeligrososQue(cosa) {
	  return cosas.filter({cosa => cosa.nivelPeligrosidad() > cosa.nivel()})
	}

	method puedecircularEnRuta(nivelMaximoDePeligrosidad) {
	  return not(self.excedidoDePeso()) && cosas.count({cosa => cosa.nivel() > nivelMaximoDePeligrosidad}) == 0
	}
}
