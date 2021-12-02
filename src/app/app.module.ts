import { NgModule } from '@angular/core';
import { BrowserModule } from '@angular/platform-browser';

import { AppRoutingModule } from './app-routing.module';
import { FormsModule, ReactiveFormsModule } from '@angular/forms';
import { HttpClientModule } from '@angular/common/http';

import { AppMaterialModule } from './modules/app-material.module';

import { AppComponent } from './app.component';
import { AlumnosComponent } from './components/alumnos/alumnos.component';
import { AlumnosModalComponent } from './components/alumnos/alumnos-modal/alumnos-modal.component';
import { CursosComponent } from './components/cursos/cursos.component';
import { CursosModalComponent } from './components/cursos/cursos-modal/cursos-modal.component';
import { RegistroNotasComponent } from './components/alumnosxcurso/registro-notas/registro-notas.component';
import { ConsultaNotasComponent } from './components/alumnosxcurso/consulta-notas/consulta-notas.component';
import { BrowserAnimationsModule } from '@angular/platform-browser/animations';
import { HeaderComponent } from './components/header/header.component';
import { NavigationComponent } from './components/navigation/navigation.component';


@NgModule({
  declarations: [
    AppComponent,
    AlumnosComponent,
    AlumnosModalComponent,
    CursosComponent,
    CursosModalComponent,
    RegistroNotasComponent,
    ConsultaNotasComponent,
    HeaderComponent,
    NavigationComponent
  ],
  imports: [
    BrowserModule,
    AppRoutingModule,
    BrowserAnimationsModule,
    AppMaterialModule,
    FormsModule,
    ReactiveFormsModule,
    HttpClientModule
  ],
  providers: [],
  bootstrap: [AppComponent]
})
export class AppModule { }
