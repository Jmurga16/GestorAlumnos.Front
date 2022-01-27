import { Component, Inject, OnInit } from '@angular/core';
import { MatDialogRef, MAT_DIALOG_DATA } from '@angular/material/dialog';
import { AlumnosService } from 'src/app/services/alumnos.service';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import { AlumnoData } from 'src/app/models/IAlumno';
import Swal from "sweetalert2";


@Component({
  selector: 'app-alumnos-modal',
  templateUrl: './alumnos-modal.component.html',
  styleUrls: ['./alumnos-modal.component.css']
})
export class AlumnosModalComponent implements OnInit {

  nIdAlumno?: number;
  formGroup: FormGroup;
  sAccionModal?: string;


  constructor(
    public dialogRef: MatDialogRef<AlumnosModalComponent>,
    private alumnosService: AlumnosService,
    @Inject(MAT_DIALOG_DATA) public data: AlumnoData,
    private fB: FormBuilder,

  ) {
    this.formGroup = this.fB.group({
      nIdAlumno: [0, Validators.required],
      sCodAlu: [""],
      sNombres: ["", Validators.required],
      sApellidos: ["", Validators.required],
      nEdad: ""
    });

  }

  ngOnInit(): void {

    //Definimos la accion Agregar o Editar
    this.sAccionModal = this.data.accion == 0 ? "Agregar" : "Editar";

    //En caso ya tenga datos
    if (this.data.accion == 1) {
      this.nIdAlumno = this.data.nIdAlumno;
      this.formGroup?.controls['nIdAlumno'].setValue(this.nIdAlumno);
      this.formGroup.controls['sCodAlu'].disable();

      this.fnCargarDatos();
    }

  }

  //#region Cerrar
  fnCerrarModal(result?: number) {
    //Resultado 1 es para insertar
    if (result == 1) {
      this.dialogRef.close(result);
    }
    //Resultado indefinido solo cierra
    else {
      this.dialogRef.close();
    }
  }
  //#endregion Cerrar


  //#region Cargar Datos para Editar
  async fnCargarDatos() {
    let pParametro = [];
    //Parametro el Identificador del Almacen
    pParametro.push(this.nIdAlumno);

    //Llamar al servicio de Alumnos para Eliminar
    this.alumnosService.fnServiceAlumnos('02', pParametro).subscribe(
      data => {
        this.formGroup?.controls['sCodAlu'].setValue(data[0].sCodAlu);
        this.formGroup?.controls['sNombres'].setValue(data[0].sNombres);
        this.formGroup?.controls['sApellidos'].setValue(data[0].sApellidos);
        this.formGroup?.controls['nEdad'].setValue(data[0].nEdad);

      });

  }
  //#endregion 


  //#region Grabar
  fnGrabar() {
    //Definir mensaje
    let sTitulo = 'Ingrese todos los campos.'

    //Validar formulario de almacen
    if (this.formGroup?.invalid) {
      Swal.fire({
        title: sTitulo,
        icon: 'warning',
        timer: 1500
      });
    }
    else {
      let pParametro = [];
      let pOpcion = this.data.accion == 0 ? '03' : '04'; // 03-> Insertar / 04-> Editar

      //Llenar formulario      
      pParametro.push(this.formGroup?.controls['sNombres'].value);
      pParametro.push(this.formGroup?.controls['sApellidos'].value);
      pParametro.push(this.formGroup?.controls['nEdad'].value);

      pParametro.push(this.nIdAlumno);

      //Llamar servicio de almacenes 05 / 06
      //Llamar al servicio de Alumnos para Guardar o Editar
      this.alumnosService.fnServiceAlumnos(pOpcion, pParametro).subscribe({
        next: (value) => {
          //Si es válido, retornar mensaje de exito
          if (value.cod == 1) {
            Swal.fire({
              title: `Se registró con éxito`,
              icon: 'success',
              timer: 3500
            }).then(() => {
              this.fnCerrarModal(1);
            });
          }
        },
        error: (e) => console.error(e),
        //complete: () => console.info('complete')
      });

    }

  }
  //#endregion


}
