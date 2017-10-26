function Trabajo2_HernandezRoman

f=figure('Name','Trabajo 2 - Santiago Hernandez Roman','NumberTitle','off','Resize','on',...
    'Position',[100 100 1000 600]);

%------------------------PANEL CONFIGURACIÓN-------------------------------

panelProp = uipanel(f,'Title','Configuración','Position',[.01 .4 .4 .59]);

labelGdl = uicontrol(panelProp,'Style','text','Units','normalized','Position',[0.03 0.77 0.4 0.2],...
            'HorizontalAlignment','left','String','Grados de libertad del robot: ');
gdlList = uicontrol(panelProp,'Style', 'popup',...
            'String', {'2','3','4','5','6','7'},'Units','normalized',...
            'Position', [0.40 0.78 0.13 0.2],'Callback',@gdlListChange);
        
precisionGoal=0.2;        
tbPrecision = uitable(panelProp,'Units','normalized','Position',[0.03 0.80 .2 .2],...
        'ColumnName',[],'RowName',{'Precisión'},'Data',precisionGoal,'ColumnFormat',{'numeric'},...
        'ColumnEditable',true,'CellEditCallback', @editPrecision);
tbPrecision.Position(3) = tbPrecision.Extent(3);
tbPrecision.Position(4) = tbPrecision.Extent(4);

gdl=gdlList.Value+1; %Porque empezamos la lista en 2    
tamRobot=[50 50 0 0 0 0 0];
tipoArt={0 0 0 0 0 0 0};
propRaw=cell(7,2);
propRaw(:,1)=num2cell(tamRobot*gdl);
tbPropRobot = uitable(panelProp,'Units','normalized','Position',[0.53 0.26 .1 .1],...
        'ColumnName',{'%Original','Prismatica'},'RowName',{'1' '2' '3' '4' '5' '6' '7'},'Data',propRaw,'ColumnFormat',{'numeric','logical'},...
        'ColumnEditable',[false true],'CellEditCallback', @editPropRobot);
tbPropRobot.Position(3) = tbPropRobot.Extent(3);
tbPropRobot.Position(4) = tbPropRobot.Extent(4); 

labelTipo = uicontrol(panelProp,'Style','text','Units','normalized','Position',[0.03 0.55 0.48 0.2],...
            'HorizontalAlignment','left','String','Tamaño y tipo de las barras del robot: ');
        
btnSelPuntos = uicontrol(panelProp,'Style', 'pushbutton', 'String', 'Seleccionar puntos de inicio y objetivo y aplicar el CCD',...
    'Units','normalized','Position', [0.03 0.03 0.94 0.15],'Callback', @selPuntos);

sldlargo=0.48;sldancho=0.055;sldpos=0.6;
sldQ1 = uicontrol(panelProp, 'Style', 'slider',...
    'Min',1,'Max',199,'Value',100,'SliderStep',[0.01 0.05],... 
    'Units','normalized','Position', [0.03 sldpos sldlargo sldancho],...
    'Callback', @s1Change,'Interruptible','off', 'BusyAction', 'cancel'); %queue
sldQ2 = uicontrol(panelProp, 'Style', 'slider',...
    'Min',1,'Max',199,'Value',100,'SliderStep',[0.01 0.05],...
    'Units','normalized','Position', [0.03 sldpos-sldancho sldlargo sldancho],...
    'Callback', @s2Change,'Interruptible','off', 'BusyAction', 'cancel');
sldQ3 = uicontrol(panelProp, 'Style', 'slider',...
    'Min',1,'Max',199,'Value',100,'SliderStep',[0.01 0.05],...
    'Units','normalized','Position', [0.03 sldpos-sldancho*2 sldlargo sldancho],...
    'Callback', @s3Change,'Interruptible','off', 'BusyAction', 'cancel');
sldQ4 = uicontrol(panelProp, 'Style', 'slider',...
    'Min',1,'Max',199,'Value',100,'SliderStep',[0.01 0.05],...
    'Units','normalized','Position', [0.03 sldpos-sldancho*3 sldlargo sldancho],...
    'Callback', @s4Change,'Interruptible','off', 'BusyAction', 'cancel');
sldQ5 = uicontrol(panelProp, 'Style', 'slider',...
    'Min',1,'Max',199,'Value',100,'SliderStep',[0.01 0.05],...
    'Units','normalized','Position', [0.03 sldpos-sldancho*4 sldlargo sldancho],...
    'Callback', @s5Change,'Interruptible','off', 'BusyAction', 'cancel');
sldQ6 = uicontrol(panelProp, 'Style', 'slider',...
    'Min',1,'Max',199,'Value',100,'SliderStep',[0.01 0.05],...
    'Units','normalized','Position', [0.03 sldpos-sldancho*5 sldlargo sldancho],...
    'Callback', @s6Change,'Interruptible','off', 'BusyAction', 'cancel');
sldQ7 = uicontrol(panelProp, 'Style', 'slider',...
    'Min',1,'Max',199,'Value',100,'SliderStep',[0.01 0.05],...
    'Units','normalized','Position', [0.03 sldpos-sldancho*6 sldlargo sldancho],...
    'Callback', @s7Change,'Interruptible','off', 'BusyAction', 'cancel');

vectorSliders=[100 100 100 100 100 100 100];


    function s1Change(hObject, eventdata, handles)
        vectorSliders(1)=sldQ1.Value;
        updateSlider(1);
    end
    function s2Change(hObject, eventdata, handles)
        vectorSliders(2)=sldQ2.Value;
        updateSlider(2);
    end
    function s3Change(hObject, eventdata, handles)
        vectorSliders(3)=sldQ3.Value;
        updateSlider(3);
    end
    function s4Change(hObject, eventdata, handles)
        vectorSliders(4)=sldQ4.Value;
        updateSlider(4);
    end
    function s5Change(hObject, eventdata, handles)
        vectorSliders(5)=sldQ5.Value;
        updateSlider(5);
    end
    function s6Change(hObject, eventdata, handles)
        vectorSliders(6)=sldQ6.Value;
        updateSlider(6);
    end
    function s7Change(hObject, eventdata, handles)
        vectorSliders(7)=sldQ7.Value;
        updateSlider(7);
    end

    function gdlListChange(hObject, eventdata, handles)
        gdl=gdlList.Value+1;
        for i=1:7
            if(i<=gdl)
                tamRobot(i)=(100/gdl);
            else
                tamRobot(i)=0;
            end
        end
        tipoArtAux=cell(7,1);
        tipoArt={0 0 0 0 0 0 0};
        tbPropRobot.Data=[num2cell(tamRobot*gdl)' tipoArtAux];
        resetSliders;
        resetRobot;
    end

    function editPrecision(hObject, eventdata, handles)
        precisionGoal=tbPrecision.Data;
        if(precisionGoal>5)
            precisionGoal=5;
            tbPrecision.Data=precisionGoal;
        elseif(precisionGoal<0.1 || isnan(precisionGoal))
            precisionGoal=0.1;
            tbPrecision.Data=precisionGoal;           
        end
    end

    function editPropRobot(hObject, eventdata, handles) 
        tbData=cell2mat(tbPropRobot.Data(:,1))';
        tipoArt=tbPropRobot.Data(:,2)';
        resetRobot;  
    end

    function selPuntos(hObject, eventdata, handles)
        %Selección de puntos inicial y final
        %Se pueden tomar varios puntos a la vez
        [x,y] = ginput(2);
        %Se limitan las posiciones de los puntos al área de trabajo del
        %robot
        pStart=limitarPuntoCirculo(x(1),y(1),10);
        pGoal=limitarPuntoCirculo(x(2),y(2),10);
        valArtInicial=metodoFastCCD(pStart); %Se situa rápidamente el robot en la posición inicial
        metodoCCD(valArtInicial); %Se lanza el metodo CCD con animaciones
    end

    function updateSlider(num)
        lMax=gdl*100;
        inc=(sum(vectorSliders(1:gdl))-lMax)/(gdl-1);
        while(abs(sum(vectorSliders(1:gdl))-lMax)>0.01)
            for i=1:gdl
                if(i~=num)
                    vectorSliders(i)=vectorSliders(i)-inc;
                    if(vectorSliders(i)<1)
                        vectorSliders(i)=1;
                    elseif(vectorSliders(i)>199)
                        vectorSliders(i)=199;
                    end      
                end
            end
            inc=(sum(vectorSliders(1:gdl))-lMax)/(gdl-1);
        end
        sum(vectorSliders(1:gdl));
        sldQ1.Value=vectorSliders(1);
        sldQ2.Value=vectorSliders(2);
        sldQ3.Value=vectorSliders(3);
        sldQ4.Value=vectorSliders(4);
        sldQ5.Value=vectorSliders(5);
        sldQ6.Value=vectorSliders(6);
        sldQ7.Value=vectorSliders(7);
        
        asignarSlidersTam;
        updateTabla;
        resetRobot;
    end 

    function updateTabla
        tipoArtCell=cell(7,1);
        for i=1:7
            tipoArtCell{i,1}=tipoArt{i};
        end
        tbPropRobot.Data=[num2cell(tamRobot*gdl)' tipoArtCell];
    end
    
    function resetSliders
        vectorSliders=[100 100 100 100 100 100 100];
        sldQ1.Value=vectorSliders(1);
        sldQ2.Value=vectorSliders(2);
        sldQ3.Value=vectorSliders(3);
        sldQ4.Value=vectorSliders(4);
        sldQ5.Value=vectorSliders(5);
        sldQ6.Value=vectorSliders(6);
        sldQ7.Value=vectorSliders(7);
        asignarSlidersTam;
    end

    function asignarSlidersTam
       for i=1:7
            if(i<=gdl)
                tamRobot(i)=(100/gdl)*(vectorSliders(i)/100);
            else
                tamRobot(i)=0;
            end
        end 
    end

    function updateTbValArt(valores)       
        for i=1:gdl
            if(tipoArt{i}==true)
                valores(i)=valores(i)*gdl;
            else
                valores(i)=rad2deg(valores(i));
                while(abs(valores(i))>360)
                    if(valores(i)>360)
                        valores(i)=valores(i)-360;
                    elseif(valores(i)<-360)
                        valores(i)=valores(i)+360;
                    end
                end
                if(valores(i)<0)
                    valores(i)=valores(i)+360;
                end 
            end
        end
        tbvalArtRobot.Data=valores';        
    end

%-------------------------PANEL DATOS ROBOT--------------------------------
panelDatos = uipanel(f,'Title','Datos del robot','Position',[.01 .01 .4 .39]);

valArtRaw=zeros(1,7)';
tbvalArtRobot = uitable(panelDatos,'Units','normalized','Position',[0.3 0.2 .8 .8],...
        'ColumnName',{'Valores Articulares'},'RowName',{'Q1' 'Q2' 'Q3' 'Q4' 'Q5' 'Q6' 'Q7'},'Data',valArtRaw,'ColumnFormat',{'numeric'});
tbvalArtRobot.Position(3) = tbvalArtRobot.Extent(3);
tbvalArtRobot.Position(4) = tbvalArtRobot.Extent(4);

labelDist = uicontrol(panelDatos,'Style','text','Position',[50 10 300 20],'FontSize',12,...
            'HorizontalAlignment','left','String','Distancia del extremo al objetivo: ');
        

%--------------------PANEL REPRESENTACIÓN ROBOT----------------------------

panelRobot = uipanel(f,'Title','Representación del robot','Position',[.415 .01 .58 .98]);

axesRobot=axes('Parent',panelRobot,'Units','Pixels','Position',[60 100 460 460]);

checkboxTrayectoria = uicontrol(panelRobot,'Style','checkbox',...
            'Position',[50 15 300 20],'Value',1,...
            'HorizontalAlignment','left','String','Mostrar trayectoria del extremo del robot',...
            'Callback', @cbTrayectoria);
checkboxPasoAPaso = uicontrol(panelRobot,'Style','checkbox',...
            'Position',[300 45 300 20],'Value',0,...
            'HorizontalAlignment','left','String','Habilitar modo "Paso a Paso"');
velList = uicontrol(panelRobot,'Style', 'popup',...
            'String', {'Baja','Media','Alta'},'Value',2,...
            'Position', [180 45 100 20]);
labelVel = uicontrol(panelRobot,'Style','text','Position',[50 42 120 20],...
            'HorizontalAlignment','left','String','Velocidad de animación:');

        
pStart=zeros(1,2);
pGoal=zeros(1,2);

trayectoriaRobot=[0,0];
ultimoValArtPintado=zeros(1,7);
%Esta variable se usa para mantener un registro de que se ha pintado para
%poder pintar o no la trayectoria cuando se modifica el checkboxTrayectoria
trabajando=0; 
forzarFin=0;
%Se lleva un registro de si el programa estaba dentro de un bucle del
%metodo CCD para forzar su acabado y esperar a que salga antes de seguir
%con el reset

pintaRobot(zeros(1,7));

    function cbTrayectoria(hObject, eventdata, handles)
        pintaRobot(ultimoValArtPintado); 
    end

    function [pOut]=limitarPuntoCirculo(pxIn,pyIn,radio)
       if(distanciaPuntos(pxIn,pyIn,0,0)>radio)
            ang=atan2(pyIn,pxIn);
            pOut(1)=10*cos(ang);
            pOut(2)=10*sin(ang);
       else
           pOut=[pxIn,pyIn];
       end
    end

    function resetRobot
        if(trabajando==1)
            forzarFin=1;
        else
            trayectoriaRobot=[0,0];
            pStart=zeros(1,2);
            pGoal=zeros(1,2);
            valArt=zeros(1,7);
            for i=1:gdl
                if(tipoArt{i}==true)
                    valArt(i)=tamRobot(i);
                end
            end
            pintaRobot(valArt);
            forzarFin=0;
        end
    end

    function [xR,yR,ang]=pintaRobot(valArt) 
        %Tambien devuelve la posicion del robot
        %Borrar el plot anterior
        axes(axesRobot);
        cla;
        hold all;
        %Dibujar borde área de trabajo
        th = 0:pi/50:2*pi;
        xc = 10*cos(th);
        yc = 10*sin(th);
        plot(xc, yc,'Color',[0.7,0.7,0.7]);
        %Dibujar comienzo y objetivo (Como circulo de radio precisión)
        scatter(pStart(1),pStart(2),'g+');
        scatter(pGoal(1),pGoal(2),'r+');
        xc = pGoal(1)+precisionGoal*cos(th);
        yc = pGoal(2)+precisionGoal*sin(th);
        plot(xc, yc,'r');
        %Dibujar la trayectoria debajo del robot
        if(checkboxTrayectoria.Value==1)
            plot(trayectoriaRobot(2:end,1),trayectoriaRobot(2:end,2),'Color',[0.9500    0.3250    0.0980]);
        end
        %Dibujar el robot segun los valores Articulares
        %%HACER FUNCION CINEMATICA
        [xR,yR,ang]=cinematicaDirecta(valArt);
        plot(xR, yR,'k','LineWidth',1);
        for i=1:gdl
            if(tipoArt{i}==true)
                plot(xR(i), yR(i),'bs','LineWidth',1); 
            else
                plot(xR(i), yR(i),'ro','LineWidth',1);
            end
        end
        %Actualizar los ejes
        axis(axesRobot,[-11 11,-11 11]); 
        %Guardar cuales han sido los valores articulares de la última
        %impresión
        ultimoValArtPintado=valArt;
        updateTbValArt(valArt);
    end

    function [xR,yR,ang]=cinematicaDirecta(valArt)
        xR=zeros(1,gdl);
        yR=zeros(1,gdl);
        ang=zeros(1,gdl);
        sumaAngulos=0;
        for i=1:gdl
            if(tipoArt{i}==true)
                xR(i+1)=xR(i)+(valArt(i)/10)*cos(sumaAngulos);
                yR(i+1)=yR(i)+(valArt(i)/10)*sin(sumaAngulos);
            else
                xR(i+1)=xR(i)+(tamRobot(i)/10)*cos(valArt(i)+sumaAngulos);
                yR(i+1)=yR(i)+(tamRobot(i)/10)*sin(valArt(i)+sumaAngulos);
                sumaAngulos=sumaAngulos+valArt(i);
            end
            ang(i)=sumaAngulos;
        end
    end

    function [pCross]=PuntoMinPrismatica(pRx,pRy,pGoalx,pGoaly,angulo)
       %Esta función se usa para obtener a que punto se cruzan la paralela al brazo prismatico que pasa por el 
       %extremo y la perpendicular que pasa por el punto objetivo
       m1=tan(angulo);
       c1=pRy-m1*pRx;
       m2=tan(angulo+(pi/2));
       c2=pGoaly-m2*pGoalx;
       xCross=(c2-c1)/(m1-m2);
       yCross=m2*xCross+c2;
       %Correcion
       if(angulo==0)
           yCross=pRy;
       end
       pCross=[xCross,yCross];
    end

    function metodoCCD(valArtInicial)
        trabajando=1;
        valArt=valArtInicial;          
        trayectoriaRobot=[0,0];
        fin=0;
        vectorDistancias=zeros(1,25);
        noConverge=0;
        for iteraciones=0:500
            %Se hace con for para limitar las iteraciones
            for iAux=0:gdl-1
                i=gdl-iAux;
                [xR,yR,ang]=cinematicaDirecta(valArt);
                pArtActual(1)=xR(i);
                pArtActual(2)=yR(i);
                if(tipoArt{i}==true)
                    %%%ARTICULACIÓN PRISMÁTICA
                    %Se calcula a donde hay que mover el extremo
                    angPrism=ang(i);
                    pCross=PuntoMinPrismatica(xR(end),yR(end),pGoal(1),pGoal(2),angPrism);
                    xDif=-xR(end)+pCross(1);
                    yDif=-yR(end)+pCross(2);
                    dPrism=xDif*cos(-angPrism)-yDif*sin(-angPrism);
                    %Y se limita a los valores máximos
                    valArtDeseado=valArt(i)+dPrism*10;
                    %Se multiplica por 10, por la regla de 3 de que si 10
                    %metros es un 100% del tamaño
                    if(valArtDeseado>=tamRobot(i))
                        valArtDeseado=tamRobot(i);
                    elseif(valArtDeseado<=0)
                        valArtDeseado=0;
                    end
                    valArtFinal=valArtDeseado;
                    switch(velList.Value)
                        case(1)
                            paso=0.2;
                        case(2)
                            paso=0.5;
                        case(3)
                            paso=1;
                    end
                    if(checkboxPasoAPaso.Value==1)
                        pintaRobot(valArt);
                        pArtDeseado=[xR(end) yR(end);pCross(1) pCross(2)];
                        plot(pArtDeseado(:,1), pArtDeseado(:,2),'--r','LineWidth',2);
                        pGoalDeseado=[pCross(1) pCross(2);pGoal(1) pGoal(2)];
                        plot(pGoalDeseado(:,1), pGoalDeseado(:,2),'--g','LineWidth',1);
                        waitforbuttonpress;
                    end
                    for j=0:paso:abs(valArtDeseado-valArt(i))
                    if(dPrism>0)
                        valArt(i)=valArt(i)+paso;
                    elseif(dPrism<0)
                        valArt(i)=valArt(i)-paso;
                    end
                    [xR,yR]=pintaRobot(valArt);
                    trayectoriaRobot(end+1,1)=xR(end);
                    trayectoriaRobot(end,2)=yR(end);
                    %Dibujar las lineas que indican que debe hacer el robot
                    pArtDeseado=[xR(end) yR(end);pCross(1) pCross(2)];
                    plot(pArtDeseado(:,1), pArtDeseado(:,2),'--r','LineWidth',2);
                    pGoalDeseado=[pCross(1) pCross(2);pGoal(1) pGoal(2)];
                    plot(pGoalDeseado(:,1), pGoalDeseado(:,2),'--g','LineWidth',1);
                    d=distanciaPuntos(pGoal(1),pGoal(2),xR(end),yR(end));
                    labelDist.String=['Distancia del extremo al objetivo: ' num2str(d)];
                    if(d<precisionGoal)
                        fin=1;
                        break;
                    else
                        vectorDistancias(1)=d;
                    end
                    pause(0.001);
                    end
                else
                    %%ARTICULACIÓN ROTATIVA
                    %Desplazando el origen de coordenadas y atan2 logramos obtener
                    %los angulos correspondientes
                    angGoal=atan2(pGoal(2)-pArtActual(2),pGoal(1)-pArtActual(1));
                    angExtremo=atan2(yR(end)-pArtActual(2),xR(end)-pArtActual(1));
                    valArtFinal=valArt(i)+(angGoal-angExtremo);
                    angResta=angGoal-angExtremo;
                    if(abs(angResta)>pi)
                        %Nos evita vueltas tontas si tenemos que rotar más de
                        %180 grados. Se rota X grados pero negativos.
                        if(angResta>0)
                            angResta=angResta-2*pi;
                        else
                            angResta=angResta+2*pi;
                        end
                    end
                    switch(velList.Value)
                        case(1)
                            paso=deg2rad(1);
                        case(2)
                            paso=deg2rad(3);
                        case(3)
                            paso=deg2rad(10);
                    end
                    %paso=deg2rad(3+(velList.Value*2));
                    if(abs(rad2deg(angResta))<10)
                        %Si el angulo es bajo se limita el paso
                        paso=paso/10;
                    end
                    if(checkboxPasoAPaso.Value==1)
                        pintaRobot(valArt);
                        pArtExtremo=[xR(i) yR(i);xR(end) yR(end)];
                        plot(pArtExtremo(:,1), pArtExtremo(:,2),'--r','LineWidth',2);
                        pArtGoal=[xR(i) yR(i);pGoal(1) pGoal(2)];
                        plot(pArtGoal(:,1), pArtGoal(:,2),'--g','LineWidth',1);
                        waitforbuttonpress;
                    end
                    for j=0:paso:abs(angResta)
                        try
                            if(angResta>0)
                                valArt(i)=valArt(i)+(paso);
                            else
                                valArt(i)=valArt(i)-(paso);
                            end
                            [xR,yR]=pintaRobot(valArt);
                            trayectoriaRobot(end+1,1)=xR(end);
                            trayectoriaRobot(end,2)=yR(end);
                            pArtExtremo=[xR(i) yR(i);xR(end) yR(end)];
                            plot(pArtExtremo(:,1), pArtExtremo(:,2),'--r','LineWidth',2);
                            pArtGoal=[xR(i) yR(i);pGoal(1) pGoal(2)];
                            plot(pArtGoal(:,1), pArtGoal(:,2),'--g','LineWidth',1);
                            d=distanciaPuntos(pGoal(1),pGoal(2),xR(end),yR(end));
                            labelDist.String=['Distancia del extremo al objetivo: ' num2str(d)];
                            if(d<precisionGoal)
                                fin=1;
                                break;
                            else
                                vectorDistancias(1)=d;
                            end
                            pause(0.001);
                        catch
                            %Se soluciona asi un error de que se cambie el
                            %numero de barras mientras se está en este bucle
                            break; 
                        end
                    end
                end
                if(fin==1||forzarFin==1)
                    break;
                else
                    valArt(i)=valArtFinal;
                    %Esta linea corrige los errores en el valor articular que
                    %se dan por el paso de animación
                    if(checkboxPasoAPaso.Value==1)
                        waitforbuttonpress;
                    end
                end
                
                %Comprobar si está claro que no converge
                if(abs(vectorDistancias(1)-mean(vectorDistancias(2:end)))<5E-4)
                    noConverge=noConverge+1;
                    %Se pueden dar falsos positivos
                    if(noConverge>100)
                        %Efectivamente no vamos a ningun lado
                        fin=1;
                    end
                end
                for i=1:length(vectorDistancias)-1
                    vectorDistancias(i+1)=vectorDistancias(i);
                end
                

            end
            if(fin==1||forzarFin==1)
                %Salimos si ha llegado a la precision
                break;
            end
        end
        pintaRobot(valArt);
        trabajando=0;
        if(forzarFin==1)
            %Si hemos salido forzado, asegurar el borrado
            resetRobot
        end
    end

    function [valArt]=metodoFastCCD(pFinal)
        trabajando=1;
        valArt=zeros(1,gdl);
        for i=1:gdl
                if(tipoArt{i}==true)
                    valArt(i)=tamRobot(i);
                end
        end
        for iteraciones=0:150
            %Se hace con for para limitar las iteraciones
            for iAux=0:gdl-1
                i=gdl-iAux;
                [xR,yR,ang]=cinematicaDirecta(valArt);
                pArtActual(1)=xR(i);
                pArtActual(2)=yR(i);
                if(tipoArt{i}==true)
                    angPrism=ang(i);
                    pCross=PuntoMinPrismatica(xR(end),yR(end),pGoal(1),pGoal(2),angPrism);
                    xDif=-xR(end)+pCross(1);
                    yDif=-yR(end)+pCross(2);
                    d=xDif*cos(-angPrism)-yDif*sin(-angPrism);
                    %Y se limita a los valores máximos
                    valArtDeseado=valArt(i)-d*10;
                    %Se multiplica por 10, por la regla de 3 de que si 10
                    %metros es un 100% del tamaño
                    if(valArtDeseado>=tamRobot(i))
                        valArtDeseado=tamRobot(i);
                    elseif(valArtDeseado<=0)
                        valArtDeseado=0;
                    end
                    valArt(i)=valArtDeseado;
                else
                %Desplazando el origen de coordenadas y atan2 logramos obtener
                %los angulos correspondientes
                    angGoal=atan2(pFinal(2)-pArtActual(2),pFinal(1)-pArtActual(1));
                    angExtremo=atan2(yR(end)-pArtActual(2),xR(end)-pArtActual(1));
                    valArt(i)=valArt(i)+(angGoal-angExtremo);
                end
                if(distanciaPuntos(pFinal(1),pFinal(2),xR(end),yR(end))<0.005)
                   break;
                end
            end
        end
        pintaRobot(valArt);
        trabajando=0;
        if(forzarFin==1)
            %Si hemos salido forzado, asegurar el borrado
            resetRobot
        end
    end

    function [distancia]=distanciaPuntos(x1,y1,x2,y2)
        distancia=sqrt((x2-x1)^2+(y2-y1)^2);
    end
 
miNombre = uicontrol('Style','text',...
            'Position',[800 0 180 20],...
            'HorizontalAlignment','left','String','Santiago Hernández Román - 2015');
        
    function [deg]=rad2deg(rad)
        deg=180*rad/pi;
    end
    function [rad]=deg2rad(deg)
        rad=pi*deg/180;
    end

end

