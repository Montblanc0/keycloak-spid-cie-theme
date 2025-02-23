# Keycloak SPID + CIE Only Theme

A Keycloak theme designed for SPID and CIE authentication, heavily based on [RedHat Italy's keycloak-spid-provider theme](https://github.com/redhat-italy/keycloak-spid-provider/tree/master/theme/keycloak-spid-only).

## Compatibility
This theme has been tested on Keycloak **v26.1.2**.
Compatibility with older or newer Keycloak versions is not guaranteed.

## Features
- Allows authentication via **SPID** or **CIE**.
- **Dynamic rendering** of IdP buttons.

![SPID login tab](https://i.ibb.co/fzVPttBL/desktop-spid-tab.png)
![CIE login tab](https://i.ibb.co/Tfsf8Nw/desktop-cie-tab.png)

- Can function as a **SPID-only** or **CIE-only** login theme, depending on available identity providers.

<p align="center">
  <img src="https://i.ibb.co/Zprg71zQ/mobile-cie-only-tab.png" alt="CIE-only tab (mobile view)" width="400">
</p>

## SPID Identity Providers
To detect SPID IdPs, their **aliases must start with** `spid`. **(Important!)**

To gain the best results and display the proper logos, use the naming convention from [keycloak-spid-provider-configuration-client](https://github.com/Montblanc0/keycloak-spid-provider-configuration-client) (which is still the recommended way of importing SPID idps):

```
spid-aruba
spid-teamsystem
spid-etnahitech
spid-sielte
spid-infocert
spid-infocamere
spid-intesi-group
spid-lepida
spid-namirial
spid-poste
spid-register.it
spid-tim
spid-spid-saml-check
spid-spid-saml-check-demo
spid-validator
spid-demo
```

Any **SPID provider alias starting with `spid`** but not in this list will display a **generic logo** but remain functional.

## CIE Identity Providers
To detect CIE IdPs, their **aliases must start with** `cie`. **(Important!)**

For best results, the production IdP alias should be exactly:

```
cieid-saml
```

This ensures the proper **"Entra con CIE"** button is displayed.

## Installation
1. Clone the repo or download the [latest release package](https://github.com/Montblanc0/keycloak-spid-cie-theme/releases).
1. Place the `keycloak-spid-cie` folder into:
   ```
   <KC_HOME>/themes/
   ```
2. Restart Keycloak.
3. In the Keycloak Admin Console:
   - Navigate to the client configuration.
   - Scroll down to **Login Settings**.
   - Set **Login theme** to `keycloak-spid-cie`.

## Hiding Unwanted Providers

If you prefer not to disable or delete your preproduction/demo IdPs, you can modify their alias so that it **does not start with "spid" or "cie"**. Since Keycloak does not allow renaming IdP aliases from the admin console, this must be done directly in the database. For example, in PostgreSQL:

```sql
UPDATE identity_provider SET provider_alias = 'hidden-spid-demo' WHERE provider_alias = 'spid-demo';
```

After making this change, restart Keycloak to ensure the provider login button is no longer displayed.

## Related Projects
- [italia/spid-keycloak-provider](https://github.com/italia/spid-keycloak-provider)
- [Montblanc0/keycloak-spid-provider-configuration-client](https://github.com/Montblanc0/keycloak-spid-provider-configuration-client)
- [Montblanc0/spid-saml-check](https://github.com/Montblanc0/spid-saml-check)
- [lscorcia/keycloak-cieid-provider](https://github.com/lscorcia/keycloak-cieid-provider)

## License
This project is released under the **Apache 2.0 License**.