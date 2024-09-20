object knightRider {
	method consecuencia() {
		
	}
	
	method bulto() = 1
	
	method peso() = 500
	
	method nivelDePeligrosidad() = 10
}

object bumblebee {
	var property transformado = null
	
	method consecuencia() {
		transformado = robot
	}
	
	method bulto() = 2
	
	method peso() = 800
	
	method nivelDePeligrosidad() = transformado.peligrosidad()
}

object auto {
	method peligrosidad() = 15
}

object robot {
	method peligrosidad() = 30
}

object paqueteDeLadrillos {
	var property ladrillo = 0
	
	method consecuencia() {
		ladrillo += 12
	}
	
	method bulto() = if (ladrillo == 0) {
		0
	} else {
		if (ladrillo < 101) {
			1
		} else {
			if (ladrillo < 301) 2 else 3
		}
	}
	
	method peso() = 2 * self.ladrillo()
	
	method nivelDePeligrosidad() = 2
}

object arenaAGranel {
	var peso = 0
	
	method consecuencia() {
		peso += 20
	}
	
	method bulto() = 1
	
	method peso() = peso
	
	method peso(_peso) {
		peso = _peso
	}
	
	method nivelDePeligrosidad() = 1
}

object bateriaAntiaerea {
	var property estaConMisiles = false
	
	method consecuencia() {
		estaConMisiles = true
	}
	
	method bulto() = if (estaConMisiles) 2 else 1
	
	method nivelDePeligrosidad() = if (estaConMisiles) 100 else 0
	
	method peso() = if (estaConMisiles) 300 else 200
}

object contenedorPortuario {
	const cosasDentro = #{}
	
	method cosasDentro() {
	return cosasDentro
	}

	method agregarCosas(cosas){
		cosasDentro.addAll(cosas)
	}

	method consecuencia() {
		cosasDentro.forEach({ cosa => cosa.consecuencia() })
	}
	
	method bulto() = 1 + cosasDentro.sum({ cosa => cosa.bulto() })
	
	method peso() = 100 + cosasDentro.sum({ cosa => cosa.peso() })
	
	method nivelDePeligrosidad() = if (not cosasDentro.isEmpty()) cosasDentro.map(
	                               		{ cosa => cosa.nivelDePeligrosidad() }
	                               	).max()
	                               else 0
}

object residuosRadioactivos {
	var property peso = 0
	
	method consecuencia() {
		peso += 15
	}
	
	method bulto() = 1
	
	method nivelDePeligrosidad() = 200
}

object embalajeDeSeguridad {
	var property cosaEmbalada = null

	method bulto() = 2
	
	method consecuencia() {
		
	}
	
	method peso() {
		return cosaEmbalada.peso()
	}
	
	method nivelDePeligrosidad() {
		return (cosaEmbalada.nivelDePeligrosidad()) / 2
	}
}