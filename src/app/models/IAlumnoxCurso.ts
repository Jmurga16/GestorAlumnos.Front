export class AlumnoxCurso {
    nIdAluCur?: number;
    nIdAlumno?: number;
    nIdCurso?: number;
    sCodAlu: string;
    sNombres: string;
    sApellidos: string;
    sNomCur:string

    constructor(sCodAlu: string, sNombres: string, sApellidos: string, sNomCur:string) {
        this.sCodAlu = sCodAlu
        this.sNombres = sNombres
        this.sApellidos = sApellidos
        this.sNomCur = sNomCur
    }
}

