import { Injectable } from '@angular/core';
import { HttpClient, HttpHeaders } from '@angular/common/http';
import { environment } from "src/environments/environment";
import { Observable } from 'rxjs';

@Injectable({
  providedIn: 'root'
})
export class AlumnosxcursoService {

  url: string = environment.API_URL_INV

  constructor(private http: HttpClient) { }

  fnServiceAlumnosxCurso(sOpcion: string, pParametro: any): Observable<any> {
    const urlEndPoint = this.url + 'AlumnosxCursoService';
    const httpHeaders = new HttpHeaders({ 'Content-Type': 'application/json' });

    const params = {
      sOpcion: sOpcion,
      pParametro: pParametro.join('|')
    };

    return this.http.post(urlEndPoint, JSON.stringify(params), { headers: httpHeaders });
  }

}
