import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';
import { AlumnosComponent } from './components/alumnos/alumnos.component';
import { ConsultaNotasComponent } from './components/alumnosxcurso/consulta-notas/consulta-notas.component';
import { RegistroNotasComponent } from './components/alumnosxcurso/registro-notas/registro-notas.component';
import { CursosComponent } from './components/cursos/cursos.component';

const routes: Routes = [
  //{ path: "", redirectTo:"alumnos",  component: AlumnosComponent, pathMatch:'full'},
  { path: "alumnos", component: AlumnosComponent },  
  { path: "cursos", component: CursosComponent },
  { path: "registro", component: RegistroNotasComponent },
  { path: "consulta", component: ConsultaNotasComponent },
  { path: "**", component: AlumnosComponent }
];

@NgModule({
  imports: [RouterModule.forRoot(routes)],
  exports: [RouterModule]
})
export class AppRoutingModule { }
