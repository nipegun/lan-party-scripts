#!/bin/bash

# Pongo a disposición pública este script bajo el término de "software de dominio público".
# Puedes hacer lo que quieras con él porque es libre de verdad; no libre con condiciones como las licencias GNU y otras patrañas similares.
# Si se te llena la boca hablando de libertad entonces hazlo realmente libre.
# No tienes que aceptar ningún tipo de términos de uso o licencia para utilizarlo o modificarlo porque va sin CopyLeft.

#-------------------------------------------------------------------------------------------------
#  Script De NiPeGun para encontrar un usuario de una EuskalEncounter cuyo NickName ya conocemos
#-------------------------------------------------------------------------------------------------

# Argumentos del script
CantArgsCorrectos=2
ArgsInsuficientes=65

# Color para las advertencias
ColorAdvertencia='\033[1;31m'
ColorArgumentos='\033[1;32m'
FinColor='\033[0m'

# Comprobar que se hayan pasado los argumentos necesarios. Si no, advertir y salir del script
if [ $# -ne $CantArgsCorrectos ]

  then

    echo ""
    echo "-------------------------------------------------------------------------"
    echo -e "${ColorAdvertencia}Mal uso del script!!${FinColor}"
    echo ""
    echo -e "El uso correcto sería: EncontrarElUsuario ${ColorArgumentos}[NickName] [NroEuskalEncounter]${FinColor}"
    echo ""
    echo "Ejemplo 1: EncontrarElUsuario Zordor 25"
    echo ""
    echo "Ejemplo 2: EncontrarElUsuario zordor 25"
    echo ""
    echo "-------------------------------------------------------------------------"
    echo ""
    exit $ArgsInsuficientes

  else

    echo ""
    echo "PROCESANDO LA ZONA A..."
    echo ""
    for FilaZonaA in {A..T}
      do
        for ColumnaZonaA in {1..128}
          do

            NickName=$(curl -s https://eps.encounter.eus/ee$2/map/lookup/A$FilaZonaA"_"$ColumnaZonaA | jq -r '.user')
            
            # Mostrar, línea a línea, cada usuario procesado.
            echo A$FilaZonaA"_"$ColumnaZonaA":"$NickName

            # Comprobar si el nombre de usuario hallado corresponde con el proporcionado como parámetro
            if [ $NickName = $1 ]; then

              Puesto=$(curl -s https://eps.encounter.eus/ee$2/map/lookup/A$FilaZonaA"_"$ColumnaZonaA | jq -r '.seat')
              echo ""
              echo "$NickName está en el puesto $Puesto"
              echo ""

              # Terminar el script
              exit 1
            fi

          # Esperar 5 segundos hasta hacer otra vez la consulta curl
          sleep 5

          done
      done

    echo ""
    echo "PROCESANDO LA ZONA B..."
    echo ""
    for FilaZonaB in {A..T}
      do
        for ColumnaZonaB in {1..128}
          do

            NickName=$(curl -s https://eps.encounter.eus/ee$2/map/lookup/B$FilaZonaB"_"$ColumnaZonaB | jq -r '.user')

            # Mostrar, línea a línea, cada usuario procesado.
            echo B$FilaZonaB"_"$ColumnaZonaB":"$NickName

            # Comprobar si el nombre de usuario hallado corresponde con el proporcionado como parámetro
            if [ $NickName = $1 ]; then

              Puesto=$(curl -s https://eps.encounter.eus/ee$2/map/lookup/B$FilaZonaB"_"$ColumnaZonaB | jq -r '.seat')
              echo ""
              echo "$NickName está en el puesto $Puesto"
              echo ""

              # Terminar el script
              exit 1
            fi

          # Esperar 5 segundos hasta hacer otra vez la consulta curl
          sleep 5

          done
      done

fi
