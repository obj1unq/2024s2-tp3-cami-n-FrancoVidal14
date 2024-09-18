object knightRider {
	method peso() { return 500 }
	method nivelPeligrosidad() { return 10 }
}

object bumblebee {
	var property transformado = null

	method peso() {
	  return 800
	}

	method nivelPeligrosidad() {
	  return transformado.peligrosidad()
	}
}

object auto {
  method peligrosidad() {
	return 15
  }
}

object robot {
  method peligrosidad() {
	return 30
  }
}

object paqueteDeLadrillos {
	var property ladrillo = 0 
	
	method peso() {
	  return 2 * self.ladrillo() 
	}

	method nivelDePeligrosidad() {
		return 2
	}
}

object arenaAGranel {
  var peso = 0

  method peso(_peso) {
	return _peso
  }

  method nivelDePeligrosidad() {
	return 1
  }
}

object bateriaAntiaerea {
  var property estaConMisiles = false
  
  method nivelDePeligrosidad() {
	return if (estaConMisiles) {100} else {0} 
  }

  method peso() {
	return if (estaConMisiles) {300} else {200} 
  }
}