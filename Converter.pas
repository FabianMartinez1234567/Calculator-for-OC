program ConverterOC;
uses
    crt;
type
    cadena11 = string[11];
const
    valores : array[0..11] of integer = (1,2,4,8,16,32,64,128,256,512,1024,2048);//Con una ecuacion se puede hacer mas facil
    valores2 : array[0..11] of integer = (2048,1024,512,256,128,64,32,16,8,4,2,1);//Despues lo tengo que cambiar
    decimales : array[0..11] of Real = (0.5,0.25,0.125,0.0625,0.03125,0.015625,0.0078125,0.00390625,0.001953125,0.0009765625,0.00048828125,0.000244140625);
//___________________________________________________________________
procedure ComplementoA12(Binario:cadena11;var ca1:cadena11);//Cuando me sale un 1, cargo un 0
var
    i:integer;
    primero:Boolean;
begin
    //Invierto todos los numeros menos el primero digito que lo mantengo igual
    primero:=True;
    for i:=0 to Length(Binario)-2 do //El menos 1 esta, porque se ejecuta una de mas owo
    begin 
        if (Binario[Length(Binario)-i] = '1') then
            begin
                ca1:='0'+ca1;
            end
        else 
            begin
                ca1:='1'+ca1;
            end;
    end;
    ca1:='1'+ca1;
end;
//___________________________________________________________________
procedure ComplementoA1(Binario:cadena11;var ca1:cadena11);//Cuando me sale un 1, cargo un 0
var
    i:integer;
begin
    //El complemento A1 lo que hace es invertir todos los digitos
    for i:=0 to Length(Binario)-1 do //El menos 1 esta, porque se ejecuta una de mas owo
    begin
        if (Binario[Length(Binario)-i] = '1') then
        begin
            ca1:='0'+ca1;
        end
        else 
            begin
                ca1:='1'+ca1;
            end;
    end;
end;
//___________________________________________________________________
procedure signo_operacion(Binario:cadena11;var numero:integer);
var
    i:integer;
begin
    //Paso el numero a decimal, usando el primero dijito como signo
    for i:=0 to (Length(Binario)-2) do //Me quedo con los primeros digitos y dejando el ultimo porque se usa para el signo
    begin
        if (Binario[Length(Binario)-i] = '1') then
        begin
            numero:=numero+valores[i]; 
        end;
    end;
end;
//___________________________________________________________________
procedure ComplementoA2(ca1:cadena11;var ca2:cadena11);//Si, todo este proceso es para sumar el carry
var
    i:integer;
    carry:Boolean;
    termino:Boolean;
begin
    termino:=False;
    carry:=False;
    for i:=0 to Length(ca1)-1 do 
    begin
        if termino then
        begin
            ca2:=ca1[Length(ca1)-i] +ca2;
        end;
        if carry then
        begin
            if ca1[Length(ca1)-i] = '0' then
            begin
                ca2:='1'+ca2;
                carry:=False;
                termino:=true;
            end
            else
                begin
                    ca2:='0'+ca2;
                end;
        end;
        
        if (i = 0) and (ca1[Length(ca1)-i] = '0') then //Miro el primer digito y tambien si es cero
        begin
            ca2:='1'+ca2;
            termino:=True;
        end
        else
            begin
                if (i = 0)then
                begin
                    ca2:='0'+ca2;
                    carry:=true;
                end;
                
            end;
    end;
end;
//___________________________________________________________________
procedure exceso(binario:cadena11;var ex2:cadena11); // Recorro el binario hasta cambiar el ultimo digito por un 0
var
    i:integer;
begin
    //Dejo todos los numeros iguales, menos el ultimo que lo cambio por un cero
    for i:=0 to Length(binario)-1 do
    begin
        if (Length(binario)-1 = (i)) then
        begin
            ex2:='0' +ex2;
        end
        else
            begin
                ex2:=binario[Length(binario)-i] +ex2;      
            end;
    end;
end;
//___________________________________________________________________
{procedure NegativoBinario(binario:cadena11;var ex2:cadena11); // Recorro el binario hasta cambiar el ultimo digito por un 0
var
    i:integer;
begin
    for i:=0 to Length(binario)-1 do
    begin
        if (Length(binario)-1 = (i)) then
        begin
            ex2:='1' +ex2;
        end
        else
            begin
                ex2:=binario[Length(binario)-i] +ex2;      
            end;
    end;
end;}
//___________________________________________________________________
procedure RangosBss(bits:integer);
var//5
    dos:integer;
    valor:integer;
begin
    dos:=2;//2^bits
    valor:=Trunc(exp(bits * ln ( dos )));//Me quedo con el entero de la operacion
    Write('Minimo Numero Negativo: No existe    ');
    Write('Maximo Numero Negativo: No existe    ');
    Write('Minimo Numero Positivo: 0    ');
    Write('Maximo Numero Positivo:',valor-1);//25 wtf  
    WriteLn('    Rango: 0..',valor-1);
end;
//___________________________________________________________________
procedure RangosCa1(bits:integer);
var
    dos:integer;
    valor:integer;
begin
    dos:=2;
    bits:=bits-1;//Resto uno porque es bcs entonces no uso el ultimo bit
    valor:=Trunc(exp(bits * ln ( dos )));
    Write('Minimo Numero Negativo: -0   |');
    Write('Maximo Numero Negativo: -',valor-1,'   |');
    Write('Minimo Numero Positivo:  0   |');
    Write('Maximo Numero Positivo:  ',valor-1,'   |');  
    WriteLn('Rango: -',valor-1,'..',valor-1,'|');
end;
//___________________________________________________________________
procedure RangosBcs(bits:integer);
var
    dos:integer;
    valor:integer;
begin
    dos:=2;
    bits:=bits-1;//Resto uno porque es bcs entonces no uso el ultimo bit
    valor:=Trunc(exp(bits * ln ( dos )));
    Write('Minimo Numero Negativo: -0   |');
    Write('Maximo Numero Negativo: -',valor-1,'   |');
    Write('Minimo Numero Positivo:  0   |');
    Write('Maximo Numero Positivo:  ',valor-1,'   |');  
    WriteLn('Rango: -',valor-1,'..',valor-1,'|');
end;
//___________________________________________________________________
procedure RangosCa2(bits:integer);
var
    dos:integer;
    valor:integer;
begin
    dos:=2;
    bits:=bits-1;//Resto uno porque es bcs entonces no uso el ultimo bit
    valor:=Trunc(exp(bits * ln ( dos )));
    Write('Minimo Numero Negativo: -1   |');
    Write('Maximo Numero Negativo: -',valor,'   |');
    Write('Minimo Numero Positivo:  0   |');
    Write('Maximo Numero Positivo:  ',valor-1,'   |');  
    WriteLn('Rango: -',valor,'..',valor-1,'|');
end;
//___________________________________________________________________
procedure RangosEx2(bits:integer);
var
    dos:integer;
    valor:integer;
begin
    dos:=2;
    bits:=bits-1;//Resto uno porque es bcs entonces no uso el ultimo bit
    valor:=Trunc(exp(bits * ln ( dos )));//2^(bits-1)
    Write('Minimo Numero Negativo: -1   |');
    Write('Maximo Numero Negativo: -',valor,'   |');
    Write('Minimo Numero Positivo:  0   |');
    Write('Maximo Numero Positivo:  ',valor-1,'   |');  
    WriteLn('Rango: -',valor,'..',valor-1);//(2^(bits-1))-1
end;
//___________________________________________________________________
procedure Binario_A_Decimal(Binario:cadena11; var resultado:Integer;negativo:Boolean);
var
    dato,i:integer;
    probando:Integer;
    ca1:cadena11;
    ca1_decimal:integer;
    bcs:integer;
    ca2:cadena11;
    ca2_decimal:integer;
    ex2:cadena11;
    ex2_decimal:integer;
    segundon:cadena11;
    segundon2:cadena11;
begin
    segundon:='';
    segundon2:='';
    dato:=0;
    probando:=0;
    bcs:=0;
    ca1:='';
    ca1_decimal:=0;
    ca2:='';
    ca2_decimal:=0;
    ex2:='';
    ex2_decimal:=0;
    //Paso el binario normal a decimal
    for i:=0 to Length(Binario)-1 do //El menos 1 esta, porque se ejecuta una de mas owo
    begin
        if (Binario[Length(Binario)-i] = '1') then
        begin
            dato:=dato+valores[i]; 
        end;
        probando:=i;
    end;

    if ( Binario[Length(Binario)-probando] = '0')  then
    begin
        WriteLn('________________________________________________________________________________________________________________________________________');
        WriteLn('Bss: ', Binario );
        WriteLn('Bss_decimal: ', dato );
        RangosBss(Length(Binario));
        WriteLn('________________________________________________________________________________________________________________________________________');
        WriteLn('Bcs: ', Binario );
        WriteLn('Bcs_decimal: ', dato );
        WriteLn('Al empezar con 0, tiene los mismos valores que el BSS');
        WriteLn('________________________________________________________________________________________________________________________________________');
        WriteLn('Ca1: ', Binario );
        WriteLn('Ca1_decimal: ', dato );
        WriteLn('Al empezar con 0, tiene los mismos valores que el BSS');
        WriteLn('________________________________________________________________________________________________________________________________________');
        WriteLn('Ca2: ', Binario );
        WriteLn('Ca2_decimal: ', dato );
        WriteLn('Al empezar con 0, tiene los mismos valores que el BSS');
        WriteLn('________________________________________________________________________________________________________________________________________');
        ComplementoA1(Binario,segundon);
        ComplementoA2(segundon,segundon2);
        Exceso(segundon2,ex2);
        WriteLn('Ex2: ',ex2);
        signo_operacion(ex2,ex2_decimal);
        WriteLn('Ex2_decimal: -', ex2_decimal );
        RangosEx2(Length(Binario));
        WriteLn('________________________________________________________________________________________________________________________________________');
    end;

    if ( Binario[Length(Binario)-probando] = '1')  then
    begin
        WriteLn('________________________________________________________________________________________________________________________________________');
        WriteLn('Bss: ', Binario);
        WriteLn('Bss_decimal: ', dato);
        RangosBss(Length(Binario));
        WriteLn('________________________________________________________________________________________________________________________________________');
        WriteLn('Bcs: ', Binario ); 
        signo_operacion(Binario,bcs);
        WriteLn('Bcs_decimal: -',bcs);
        RangosBcs(Length(Binario));
        WriteLn('________________________________________________________________________________________________________________________________________');
        if negativo then //Como el decimal es negativo, siempre me quedo con el ultimo numero
        begin
            ComplementoA12(Binario,ca1);
            WriteLn('Ca1: ', ca1 );  
        end
        else
            begin
                ComplementoA1(Binario,ca1);
                WriteLn('Ca1: ', ca1 );  
            end;
        
        signo_operacion(ca1,ca1_decimal);
        WriteLn('Ca1_decimal: -', ca1_decimal );
        RangosCa1(Length(Binario));
        WriteLn('________________________________________________________________________________________________________________________________________');
        ComplementoA2(ca1,ca2);
        WriteLn('Ca2: ', ca2 );
        signo_operacion(ca2,ca2_decimal);
        WriteLn('Ca2_decimal: -', ca2_decimal );
        RangosCa2(Length(Binario));
        //RangosCa2(Length(Binario));
        WriteLn('________________________________________________________________________________________________________________________________________');
        if negativo then//Cuando el numero decimal es negativo, tenemos que usar el ca2 para pasarlo a ex2
        begin
            Exceso(ca2,ex2);
        end
            else
                Exceso(Binario,ex2);
        WriteLn('Ex2: ',ex2);
        signo_operacion(ex2,ex2_decimal);
        WriteLn('Ex2_decimal: ', ex2_decimal );
        RangosEx2(Length(Binario));
        WriteLn('________________________________________________________________________________________________________________________________________');
    end;
    resultado:=dato;
end;
//___________________________________________________________________
procedure Decimal_Binario(decimal:Integer;var binario:cadena11;var Negativo:Boolean);
var
    i:Integer;
    grande:integer;
begin
    Negativo:=False;
    grande:=999;
    if (decimal < 0) then//Lo que hago es mirar si el numero es negativo, lo multiplico por -1 para poder 
    begin //Trabajar sobre el mismo de manera mas comoda
        decimal:=decimal*-1;//-32
        Negativo:=True;
        WriteLn('Como es negativo tomaremos 8 o 16 bits para representarlo');
    end;
    //___________________________________
    for i:=1 to 11 do 
    begin//Buscamos en el arreglo, cual es el numero mas grande, sin pasarse del numero ingresado
        if (valores2[i]<=decimal) then //Al ser un arreglo inverso, siempre vamos a tener numeros mas altos
        begin //Una vez que el numero es mas chico, lo restamos al numero original, mientras sea mayor, agregamos ceros
            binario:=binario+'1';
            decimal:=decimal-valores2[i];
            if grande>=i then
            begin
                grande:= i-1;  
            end;
        end
            else
                begin
                    binario:=binario+'0';
                end;
    end;
    //___________________________________
    Delete(binario,1,grande); //Elimino los ceros que sobran, para esto miramos cual fue el ultima uno y a partir de ese
    if (Negativo) then //eliminamos
    begin
        while  ((Length(binario)+1)<8) do //Relleno los espacios vacios del ultimo 1 hasta llegar al ultimo bit
        begin //Que en este caso trabajaremos con 8 bits
            binario:='0'+binario;
        end;
        binario:='1'+binario; //Cuando llega al ultimo, agregamos el 1 ya que nos indica que es un binario con signo
    end;
end;

//___________________________________________________________________
procedure Caracteristicas_Binario();
var//Leo un binario y paso tadas sus caracteristicas por pantalla
    binario:cadena11;
    resultado:Integer;
    negativo:Boolean;
begin
    negativo:=False;
    binario:='';
    resultado:=0;   
    writeln('Ingrese un numero Binario: ');
    ReadLn(Binario);
    Binario_A_Decimal(Binario,resultado,negativo);
    WriteLn('Decimal: ', resultado);
    WriteLn('Bits: ',Length(Binario));
end;

//___________________________________________________________________
procedure Caracteristicas_Decimal();//Leo el decimal y miro si en negativo o no
var
    decimal:integer;
    Binario:cadena11;
    resultado:integer;
    Negativo:Boolean;
begin
    decimal:=0;
    Binario:='';
    resultado:=0;  
    writeln('Ingrese un numero Decimal: ');
    ReadLn(decimal);
    Decimal_Binario(decimal,Binario,Negativo);
    WriteLn('El binario es: ', Binario);
    Binario_A_Decimal(Binario,resultado,Negativo);
    WriteLn('Bits: ',Length(Binario));//El length lo que hace es darnos la longitud de cierto numero
    //Que en este caso es un binario

end;
//___________________________________________________________________
var
    Elegir:Integer;
begin
    //El tipico menu
    clrscr;//Elimina lo escrito anteriormente en la consola
    Elegir:=0;
    WriteLn('________________________________________________________________________________________________________________________________________');
    while (Elegir <> 3)   do
    begin
        writeln('Elija una opcion: ');
        WriteLn('1) Caracteristicas de un Binario.');
        WriteLn('2) Caracteristicas de un Decimal.');
        WriteLn('3) Terminar.');
        Write('Opcion:');
        ReadLn(Elegir);
        clrscr;
        case Elegir of
            1: Caracteristicas_Binario();   
            2: Caracteristicas_Decimal();
        end;
        WriteLn('________________________________________________________________________________________________________________________________________');
    end;
    clrscr;
end.