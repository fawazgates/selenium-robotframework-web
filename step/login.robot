*** Settings ***
Library                   SeleniumLibrary
Suite Setup               Open Browser    ${WebSauceDemo}   ${BROWSER}
Suite Teardown            Close Browser
Variables                 ../resources/login_locators.yaml


*** Variables ***
${WebSauceDemo}    https://www.saucedemo.com/
${URL_PRODUCT}    https://www.saucedemo.com/inventory.html
${URL_CHECKOUT}    https://www.saucedemo.com/checkout-step-one.html
${BROWSER}                 chrome
${MAX_LOAD_TIME}    3


*** Keywords ***

Input Username
    Input Text    ${txtUsername}    standard_user

Input password
    Input Text    ${txtPassword}    secret_sauce

Input invalid Username
    Input Text    ${txtUsername}    123

Input invalid password
    Input Text    ${txtPassword}    123

Click Button Login
    Click Element   ${btnLogin}
    Sleep    1s

Verify On Login Page
    Page Should Contain    Sauce Labs Backpack

Verify On Login Failed
    Page Should Contain    Epic sadface: Username and password do not match any user in this service

Verify on Login Failed null Username
    Page Should Contain    Epic sadface: Username is required

Verify on Login Failed null Password
    Page Should Contain    Epic sadface: Password is required

Clear Username
    Clear Element Text    ${txtUsername}

Clear Password
    Clear Element Text    ${txtPassword}

Tambahkan Produk Ke Keranjang
    [Documentation]    Menambahkan produk pertama ke keranjang.
    Click Element    ${addToCartButton}
    Sleep    1s

Verify Produk Ditambahkan Ke Keranjang
    [Documentation]    Memverifikasi produk berhasil ditambahkan ke keranjang.
    Element Text Should Be    ${cartBadge}    1

Hapus Produk Dari Keranjang
    [Documentation]    Menghapus produk pertama dari keranjang.
    Click Element    ${removeFromCartButton}
    Sleep    1s

Klik Nama Produk
    Click Element    ${productName}
    Sleep    1s

Verify Detail Produk
    Wait Until Element Is Visible    ${productDetail}    10s
    Page Should Contain Element    ${productDetail}

Input Checkout Information
    [Arguments]    ${firstName}    ${lastName}    ${postalCode}
    Input Text    ${firstNameField}    ${firstName}
    Input Text    ${lastNameField}    ${lastName}
    Input Text    ${postalCodeField}    ${postalCode}
    Click Element    ${continueButton}

Verify Checkout Success
    Wait Until Element Is Visible    ${confirmationMessage}    10s
    Page Should Contain Element    ${confirmationMessage}

Logout User
    Wait Until Element Is Visible    ${menuButton}    10s
    Wait Until Element Is Enabled    ${menuButton}    10s
    Click Element    ${menuButton}
    Wait Until Element Is Visible    ${logoutLink}    10s
    Wait Until Element Is Enabled    ${logoutLink}    10s
    Click Element    ${logoutLink}

Verify Redirected To Login Page
    Wait Until Element Is Visible    ${btnLogin}    15s
    Page Should Contain Element    ${txtUsername}

Measure Page Load Time
    [Arguments]    ${WebSauceDemo}
    ${start_time}=    Get Time    epoch
    Go To    ${WebSauceDemo}
    ${end_time}=    Get Time    epoch
    ${load_time}=    Evaluate    ${end_time} - ${start_time}
    Log    Halaman ${WebSauceDemo} dimuat dalam waktu ${load_time} detik
    Should Be True    ${load_time} < ${MAX_LOAD_TIME}    Halaman ${WebSauceDemo} memuat lebih lama dari ${MAX_LOAD_TIME} detik

*** Test Cases ***

# User login with valid data
#     Input Username
#     Input password
#     Click button login
#     Verify on Login page

# User Login with invalid data
#     Input invalid Username
#     Input invalid password
#     Click button login
#     Verify on Login failed

# User Login with empty Username
#     Clear Username
#     Input password
#     Click button login
#     Verify on Login Failed null Username

# User Login with empty Password
#     Input Username
#     Clear password
#     Click button login
#     Verify on Login Failed null Password

# Menambahkan Produk ke Keranjang
#     [Documentation]    Test case ini menguji apakah pengguna dapat menambahkan produk ke keranjang.
#     [Tags]    Produk
#     Input Username
#     Input password
#     Click button login
#     Verify On Login Page
#     Tambahkan Produk Ke Keranjang
#     Verify Produk Ditambahkan Ke Keranjang

# Menghapus Produk dari Keranjang
#     Input Username
#     Input password
#     Click button login
#     Verify On Login Page
#     Tambahkan Produk Ke Keranjang
#     Hapus Produk Dari Keranjang

# Melihat Detail Produk
#     Input Username
#     Input password
#     Click button login
#     Verify On Login Page
#     Klik Nama Produk
#     Verify Detail Produk

# Checkout dengan Informasi Lengkap
#     [Documentation]    Test case ini menguji apakah pengguna dapat berhasil melakukan checkout dengan informasi lengkap.
#     Input Username
#     Input password
#     Click button login
#     Verify On Login Page
#     Tambahkan Produk Ke Keranjang
#     Click Element    ${cartButton}
#     Click Element    ${checkoutButton}
#     Input Checkout Information    John    Doe    12345
#     Click Element    ${finishButton}
#     Verify Checkout Success

# Checkout dengan Informasi Tidak Lengkap
#     [Documentation]    Test case ini menguji apakah pengguna mendapatkan pesan kesalahan saat mencoba checkout dengan informasi yang tidak lengkap.
#     Input Username
#     Input password
#     Click button login
#     Verify On Login Page
#     Tambahkan Produk Ke Keranjang
#     Click Element    ${cartButton}
#     Click Element    ${checkoutButton}
#     Input Checkout Information    John    Doe    12345
#     Click Element    ${cancelButton}

# Logout dari Aplikasi
#     Input Username
#     Input password
#     Click button login
#     Verify On Login Page
#     Logout User

# Akses Langsung ke Halaman Produk Tanpa Login
#     [Documentation]    Test case ini menguji apakah pengguna diarahkan kembali ke halaman login saat mencoba mengakses langsung halaman produk tanpa login.
#     Go To    ${URL_PRODUCT}
#     Verify Redirected To Login Page

# Kecepatan Loading Halaman
#     [Documentation]    Test case ini mengukur waktu yang diperlukan untuk memuat halaman utama, halaman produk, dan halaman checkout.
#     Input Username
#     Input password
#     Click button login
#     # Mengukur waktu untuk memuat halaman produk
#     Measure Page Load Time    ${URL_PRODUCT}

#     # Mengukur waktu untuk memuat halaman checkout
#     Measure Page Load Time    ${URL_CHECKOUT}