import { Component, OnInit } from '@angular/core';
import { CursosService } from 'src/app/services/cursos.service';

@Component({
  selector: 'app-cursos-modal',
  templateUrl: './cursos-modal.component.html',
  styleUrls: ['./cursos-modal.component.css']
})
export class CursosModalComponent implements OnInit {

  constructor(
    private cursosService: CursosService
  ) { }

  ngOnInit(): void {
  }

}
