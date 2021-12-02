import { Component, OnInit, ViewChild } from '@angular/core';
import { FormControl } from '@angular/forms';
import { MatDialog } from '@angular/material/dialog';
import { MatPaginator } from '@angular/material/paginator';
import { MatSort } from '@angular/material/sort';
import { MatTableDataSource } from '@angular/material/table';
import { AlumnosxcursoService } from 'src/app/services/alumnosxcurso.service';
import Swal from 'sweetalert2';

@Component({
  selector: 'app-consulta-notas',
  templateUrl: './consulta-notas.component.html',
  styleUrls: ['./consulta-notas.component.css']
})
export class ConsultaNotasComponent implements OnInit {

  fCodigo = new FormControl;
  promedio: number = 0

  listaNotas: Notas[] = []

  dataSource: MatTableDataSource<any>;
  displayedColumns: string[] = [

    'sCodAlu',
    'sNombres',
    'sNomCur',
    'nNota'
  ];

  @ViewChild(MatPaginator)
  paginator!: MatPaginator;
  @ViewChild(MatSort)
  sort!: MatSort;

  constructor(
    private alumnoxCursoService: AlumnosxcursoService,
    public dialog: MatDialog
  ) {

    this.dataSource = new MatTableDataSource();
    this.dataSource.paginator = this.paginator;
    this.dataSource.sort = this.sort;

  }

  ngOnInit(): void {

  }

  //#region Consultar
  fnConsultar() {

    let pParametro: any = [];
    pParametro.push(this.fCodigo.value)

    this.alumnoxCursoService.fnServiceAlumnosxCurso('01', pParametro).subscribe(
      data => {

        this.listaNotas = data;
        if (this.listaNotas.length > 0) {
          this.dataSource = new MatTableDataSource(this.listaNotas);
          this.dataSource.paginator = this.paginator;
          this.dataSource.sort = this.sort;

          this.fnPromediar();
        }
        else {
          Swal.fire({
            title: 'Advertencia',
            text: 'El codigo del Alumno no existe',
            icon: 'warning'
          })
        }

      });



  }
  //#endregion


  //#region Abrir Modal
  async fnAbrirModal(accion: number, nIdAluCur: number) {

    /* console.log(accion)
    console.log(nIdAluCur)
   
    const dialogRef = this.dialog.open(AlumnosModalComponent, {
      width: '50rem',
      disableClose: true,
      data: {
        accion: accion, 
        nIdAlumno: nIdAluCur
      },
    });
    
    dialogRef.afterClosed().subscribe((result: any) => {
      
      if (result !== undefined) {
        
        this.fnListarAlumnos();
      }
    }); */
  }
  //#endregion Abrir Modal


  //#region Eliminar
  async fnEliminar(nIdUsuario: number) {
    let sTitulo: string, sRespuesta: string;

    //Asignar Titulo de Mensaje 
    sTitulo = '¿Desea eliminar la Nota del Alumno?';
    //Asignar Respuesta segun cambio
    sRespuesta = 'Se eliminó la Nota con éxito';

    //Mensaje de confirmacion
    var resp = await Swal.fire({
      title: sTitulo,
      icon: 'question',
      showCancelButton: true,
      confirmButtonColor: '#3085d6',
      cancelButtonColor: '#d33',
      confirmButtonText: 'Aceptar',
      cancelButtonText: 'Cancelar'
    })

    //Si se responde no
    if (!resp.isConfirmed) {
      return;
    }

    //Definicion parametros
    let pParametro = [];
    //Identificador de Usuario
    pParametro.push(nIdUsuario);

    //Llamar al servicio de Alumnos para Eliminar
    this.alumnoxCursoService.fnServiceAlumnosxCurso('05', pParametro).subscribe({
      next: (data) => {
        if (data.mensaje == "Ok") {
          Swal.fire({
            title: sRespuesta,
            icon: 'success',
            timer: 4500
          })
        }
        //Se lista nuevamente los almacenes
        this.fnConsultar();
      },
      error: (e) => console.error(e),
      //complete: () => console.info('complete')
    });
  }
  //#endregion Eliminar


  //#region Promediar
  fnPromediar() {
    //Multiplicacion Nota * credito / sumaCreditos
    let notaCred: number = 0
    let sumaCred: number = 0
    if (this.listaNotas.length > 0) {
      for (let i = 0; i < this.listaNotas.length; i++) {
        if (this.listaNotas[0].nNota != null) {
          notaCred = notaCred + (this.listaNotas[0].nNota * this.listaNotas[0].nCreditos)
        }
        sumaCred = sumaCred + this.listaNotas[0].nCreditos
      }
      this.promedio = (notaCred / sumaCred);
    }
    else {
      this.promedio = 0
    }

  }
  //#endregion

}

interface Notas {
  nIdAluCur: number,
  nIdAlumno: number,
  nIdCurso: number,
  sCodAlu: string,
  sCodCur: string,
  sNomCur: string,
  sNombres: string,
  sApellidos: string,
  nNota: number,
  nCreditos: number,
}