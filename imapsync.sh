#!/usr/bin/env bash 


# hamza@oblady.fr - Syntaxe  de fichiers
# Merci de préciser le nom d'utilisateur et le mot de passe de la source en premier,
# puis de préciser le nom d'utilisateur et le mot de passe du serveur destinataire
# example : toto@toto.com:paswword1:toto@newtoto.com:password2(séparer donc par des espaces).
# Si plusieurs compte à synchro :
# compte1:mdp1:compte1newserv:mdp1newserv
# compte2:mdp2:compte2newserv:mdp2newserv
# Version 1.0.0

VERS=1.0.0
echo -e "\e[00;31mVersion ${VERS} -> if(Question) mailto(hamza@oblady.fr) use imapsync --help for more support\e[00m"
# Si besoin d'options supplementaire -> For example : --tls1 --tls2 pour activer le tls voir imapsync --help pour avoir la liste 
# des options.
cp imapsync /usr/bin/
OPTION="--tls1 --tls2"

echo "Nous allons commencer le sync des comptes : "
timestamp=$(date +%Y_%m_%d_%H_%M_%S)
#Le serveur Source :
HOST1=

#Le serveur de destinations :
HOST2=

{ while IFS=":" read user1 password1 user2 password2
		do


           if  imapsync \
		   --host1 ${HOST1} --user1 ${user1} --password1 ${password1} \
		   --host2 ${HOST2} --user2 ${user2} --password2 ${password2} ${OPTION}
		echo "Synchro du compte ${user1}:";
then

		        continue
fi



done } < CompteSynchro.txt
cd LOG_imapsync/
{ for filename in *.txt; do grep 'Failure' $filename | tail -1 |  grep -E -o "\b[a-zA-Z0-9.-]+@[a-zA-Z0-9.-]+\.[a-zA-Z0-9.-]+\b"; done } > log.txt
cp log.txt ../log_${timestamp}.txt
cd ../
cp -R LOG_imapsync LOG_impasync_${timestamp}
rm -R LOG_imapsync