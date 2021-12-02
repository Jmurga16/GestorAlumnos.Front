export class Alumno {
    nIdAlumno?: number;
    sCodAlu: string;
    sNombres: string;
    sApellidos: string;

    constructor(sCodAlu: string, sNombres: string, sApellidos: string) {
        this.sCodAlu = sCodAlu
        this.sNombres = sNombres
        this.sApellidos = sApellidos
    }
}

export interface AlumnoData {
    accion: number;
    nIdAlumno:number;  
}