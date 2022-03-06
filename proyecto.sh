comprobacion=`service ssh status`

if [ -z "$comprobacion" ];then
	echo "No se encuentra SSH en el sistema"
	echo "¿Quieres instalar SSH? y/n: "
	read instalacion
if [ $instalacion = "y" ];then

sudo apt install openssh-server -y
else
exit
fi



else
eleccion=9
while [ $eleccion != 5 ]

do
echo "------------------------"

echo "1. Configuracion de SSH"
echo "2. Eliminar el servicio SSH"
echo "3. Ver estado de SSH"
echo "4. Banner Motd para SSH"
echo "5. Salir"

echo " Dime una opción "
echo "------------------------"
read eleccion

	if [ $eleccion -eq 1 ];then
puertoconfi=`cat /etc/ssh/sshd_config | grep -E ".Port" | sed -E "s/ +/;/g" | cut -d";" -f2`
tiempoconfi=`cat /etc/ssh/sshd_config | grep -E ".LoginGraceTime" | sed -E "s/ +/;/g" | cut -d";" -f2`
rootconfi=`cat /etc/ssh/sshd_config | grep -E ".PermitRootLogin" | sed -E "s/ +/;/g" | cut -d";" -f2`
maxautenconfi=`cat /etc/ssh/sshd_config | grep -E ".MaxAuthTries" | sed -E "s/ +/;/g" | cut -d";" -f2`
maxsesiconfi=`cat /etc/ssh/sshd_config | grep -E ".MaxSessions" | sed -E "s/ +/;/g" | cut -d";" -f2`
	echo "El puerto de SSH es: "
	sleep 0.5
	echo $puertoconfi
	sleep 0.5

	echo "El tiempo de gracia elegido es: "
	sleep 0.5
	echo $tiempoconfi
	sleep 0.5

	echo "¿Root estará habilitado?"
	sleep 0.5
		if [ $rootconfi = "prohibit-password" ];then
		sleep 1
		rootconfi="Root no se puede loguear"
		echo $rootconfi
		else
			sleep 1
			rootconfi="Root se puede loguear"
			echo $rootconfi
		fi
	sleep 0.5
	echo "Máximo de intentos para loguearse: "
	sleep 0.5
	echo $maxautenconfi

	sleep 0.5
	echo "Máximo de sesiones: "
	sleep 0.5
	echo $maxsesiconfi
	sleep 0.5
	echo " ¿Quieres reconfigurar SSH? y/n: "
	read reconfi

	if [ $reconfi = "y" ];then
	echo "Puerto actual $puertoconfi"
	echo "Nuevo puerto: "
	read puerto

	echo "Tiempo de gracia actual $tiempoconfi"
	echo "Nuevo tiempo de gracia: "
	read gracia

	echo "Actualmente $rootconfi"
	echo "Indica como quieres que sea el log de root (yes/prohibit-password): "
	read log

	echo "El numero de intentos actuales son $maxautenconfi "
	echo "Nuevo numero de intentos"
	read intentos

	echo "El numero de sesiones actuales simultaneas son $maxsesiconfi"
	echo "Nuevo numero de sesiones maximas"
	read sesiones

sudo sed -i "s/Port.*/Port $puerto/g" /etc/ssh/sshd_config
sudo sed -i "s/LoginGraceTime.*/LoginGraceTime $gracia/g" /etc/ssh/sshd_config
sudo sed -i "s/MaxAuthTries.*/MaxAuthTries $intentos/g" /etc/ssh/sshd_config
sudo sed -i "s/MaxSessions.*/MaxSessions $sesiones/g" /etc/ssh/sshd_config
sudo sed -i "s/PermitRootLogin.*/PermitRootLogin $log/g" /etc/ssh/sshd_config

fi
	fi

	if [ $eleccion -eq 2 ];then
		eliminar=`sudo apt purge openssh-server -y`
		echo "Se ha eliminado SSH"

	fi

if [ $eleccion -eq 3 ]; then

estadossh=`sudo service ssh status`
echo "$estadossh"
fi

if [ $eleccion -eq 4 ];then
sudo sed -i "s/PrintMotd.*/PrintMotd yes/g" /etc/ssh/sshd_config
echo 'banner /etc/ssh/mensaje_bienvenida' | sudo tee -a /etc/ssh/sshd_config
echo "¿Que mensaje de bienvenida quieres?"
read banner
echo "$banner" | sudo tee /etc/ssh/mensaje_bienvenida


fi

done
fi
