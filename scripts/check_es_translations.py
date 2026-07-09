#!/usr/bin/env python3
"""Check Spanish translations on each page of the site"""

import subprocess
import json
import re
import sys
from urllib.parse import quote

BASE = 'http://localhost:8080'

def curl(url):
    try:
        result = subprocess.run(
            ['curl', '-sL', url, '-m', '10'],
            capture_output=True, text=True, timeout=15
        )
        return result.stdout
    except Exception as e:
        return ''

pages = [
    ('/', 'Home'),
    ('/about-us', 'About'),
    ('/listings', 'Listings'),
    ('/blog', 'Blog'),
    ('/faq', 'FAQ'),
    ('/pricing', 'Pricing'),
    ('/contact', 'Contact'),
    ('/vendors', 'Vendors'),
    ('/products', 'Products'),
    ('/user/login', 'Login'),
    ('/user/signup', 'Signup'),
    ('/user/forget-password', 'Forgot password'),
]

# Key indicators to look for per page
checks = {
    'Home': [
        ('Inicio', 'Dashboard → Inicio'),
        ('Iniciar Sesión', 'Login → Iniciar Sesión'),
        ('Registrarse', 'Register → Registrarse'),
        ('Contáctenos', 'Contact Us → Contáctenos'),
        ('Acerca de Nosotros', 'About Us → Acerca de Nosotros'),
        ('Blog', 'Blog'),
        ('Anuncios', 'Listings → Anuncios'),
        ('Proveedores', 'Vendors → Proveedores'),
        ('FAQ', 'FAQ'),
        ('Precios', 'Pricing → Precios'),
        ('Tienda', 'Shop → Tienda'),
        ('Síguenos', 'Follow Us → Síguenos'),
    ],
    'About': [
        ('Acerca de', 'About → Acerca de'),
    ],
    'Listings': [
        ('Anuncios', 'Listings → Anuncios'),
        ('Buscar', 'Search → Buscar'),
        ('Categoría', 'Category → Categoría'),
        ('Ubicación', 'Location → Ubicación'),
        ('Filtros', 'Filters → Filtros'),
    ],
    'Blog': [
        ('Blog', 'Blog'),
        ('Buscar', 'Search → Buscar'),
    ],
    'FAQ': [
        ('FAQ', 'FAQ'),
        ('Preguntas Frecuentes', 'FAQ title → Preguntas Frecuentes'),
    ],
    'Pricing': [
        ('Precios', 'Pricing → Precios'),
        ('Paquete', 'Package → Paquete'),
        ('Mensual', 'Monthly → Mensual'),
        ('Anual', 'Yearly → Anual'),
    ],
    'Contact': [
        ('Contáctenos', 'Contact Us → Contáctenos'),
        ('Enviar Mensaje', 'Submit Message → Enviar Mensaje'),
        ('Nombre', 'Name → Nombre'),
        ('Correo Electrónico', 'Email → Correo Electrónico'),
        ('Asunto', 'Subject → Asunto'),
    ],
    'Login': [
        ('Iniciar Sesión', 'Login → Iniciar Sesión'),
        ('Contraseña', 'Password → Contraseña'),
        ('¿Olvidó su Contraseña?', 'Forgot Password?'),
        ('Recordarme', 'Remember Me → Recordarme'),
    ],
    'Signup': [
        ('Registrarse', 'Signup → Registrarse'),
        ('Registro completado', 'Sign up completed'),
    ],
    'Forgot password': [
        ('Olvidar Contraseña', 'Forget Password → Olvidar Contraseña'),
        ('Correo Electrónico', 'Email → Correo Electrónico'),
    ],
    'Vendors': [
        ('Proveedores', 'Vendors → Proveedores'),
        ('Buscar', 'Search → Buscar'),
    ],
    'Products': [
        ('Productos', 'Products → Productos'),
        ('Tienda', 'Shop → Tienda'),
        ('Buscar', 'Search → Buscar'),
    ],
}

found = {}
missing = {}

print('=' * 70)
print(f'{"PAGE":<25} {"STATUS":<10} {"TRANSLATED / TOTAL":<20}')
print('=' * 70)

for path, name in pages:
    url = f'{BASE}{path}'
    html = curl(url)
    
    if not html or '404 Not Found' in html:
        print(f'{name:<25} {"❌ 404":<10}')
        continue
    
    page_checks = checks.get(name, [])
    page_found = 0
    page_missing = []
    
    for text, label in page_checks:
        if text.lower() in html.lower():
            page_found += 1
        else:
            page_missing.append(label)
    
    status = '✅' if page_found == len(page_checks) else '⚠️'
    print(f'{name:<25} {status:<10} {page_found}/{len(page_checks)}')
    
    if page_missing:
        for m in page_missing:
            print(f'  {"":<25}   ✗ {m}')

# Also check if page has english-only fallbacks
print()
print('=' * 70)
print('CHECKING FOR ENGLISH FALLBACKS')
print('=' * 70)

# Load the translation file to see what's available
with open('/Users/admin/Documents/dev/profiexp.com/app/resources/lang/es.json') as f:
    translations = json.load(f)

english_keys = [k for k, v in translations.items() if k == v]
print(f'\nTotal keys in es.json: {len(translations)}')
print(f'Keys still in English (fallback): {len(english_keys)}')
if english_keys:
    print(f'  Examples: {english_keys[:10]}')
