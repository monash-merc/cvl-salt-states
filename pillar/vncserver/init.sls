vncserver:
  {% if grains['os'] == 'CentOS' %}
  pkg_name: tigervnc-server
  wm_pkg_name: 
    - xorg-x11-twm
    - xorg-x11-server-utils
  fonts:
    - xorg-x11-fonts-100dpi
    - xorg-x11-fonts-75dpi
    - xorg-x11-fonts-ISO8859-1-100dpi                   
    - xorg-x11-fonts-ISO8859-1-75dpi                   
    - xorg-x11-fonts-ISO8859-14-100dpi                   
    - xorg-x11-fonts-ISO8859-14-75dpi                   
    - xorg-x11-fonts-ISO8859-15-100dpi                   
    - xorg-x11-fonts-ISO8859-15-75dpi                   
    - xorg-x11-fonts-ISO8859-2-100dpi                   
    - xorg-x11-fonts-ISO8859-2-75dpi                   
    - xorg-x11-fonts-ISO8859-9-100dpi                   
    - xorg-x11-fonts-ISO8859-9-75dpi                   
    - xorg-x11-fonts-Type1                   
    - xorg-x11-fonts-cyrillic                   
    - xorg-x11-fonts-ethiopic                   
    
  {% elif grains['os'] == 'Ubuntu' %}
  pkg_name: tightvncserver
  wm_pkg_name: 
    - twm
  {% endif %}
  
