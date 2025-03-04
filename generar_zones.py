import os
import shutil  # 🆕 Llibreria per eliminar carpetes

# Eliminar la carpeta 'zones' si existeix
if os.path.exists('zones'):
    shutil.rmtree('zones')
    print("Carpeta 'zones' eliminada.")

# Crear la carpeta 'zones' de nou
os.makedirs('zones', exist_ok=True)
print("Carpeta 'zones' creada de nou.")

# Carregar la plantilla
with open('db.default.local', 'r') as f:
    plantilla = f.read()

# Llegir els dominis del fitxer
with open('dominis.txt', 'r') as f:
    dominis = f.readlines()

# Construïm les entrades de zona per named.conf.local
zones = ""
for linia in dominis:
    domini, ip = linia.strip().split(';')
    nom_fitxer = f"zones/db.{domini}"
    
    # Personalitzar la plantilla per a cada domini
    contingut = plantilla.replace("{DOMINI}", domini).replace("{IP}", ip)
    
    # Escriure el fitxer personalitzat a la carpeta 'zones'
    with open(nom_fitxer, 'w') as f:
        f.write(contingut)
    
    # Construir l'entrada per a named.conf.local amb la ruta correcta
    zones += f"""
zone "{domini}" {{
    type master;
    file "/etc/bind/zones/db.{domini}";
}};
"""

    print(f"Fitxer creat: {nom_fitxer}")

# Escriure les entrades de zona a named.conf.local
with open('named.conf.local', 'w') as f:
    f.write(zones)

print("Zones afegides correctament a named.conf.local")
