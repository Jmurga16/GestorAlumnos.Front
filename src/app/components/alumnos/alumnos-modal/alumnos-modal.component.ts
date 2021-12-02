import { Component, OnInit } from '@angular/core';
import { AlumnosService } from 'src/app/services/alumnos.service';

@Component({
  selector: 'app-alumnos-modal',
  templateUrl: './alumnos-modal.component.html',
  styleUrls: ['./alumnos-modal.component.css']
})
export class AlumnosModalComponent implements OnInit {

  constructor(
    private alumnosService: AlumnosService
  ) { }

  ngOnInit(): void {
  }

  

}
