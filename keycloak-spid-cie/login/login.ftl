<#import "template.ftl" as layout>
<@layout.registrationLayout displayMessage=!messagesPerField.existsError('username','password') displayInfo=realm.password && realm.registrationAllowed && !registrationDisabled??; section>
    <#if section = "header">
        ${msg("loginAccountTitle")}
    <#elseif section = "form">
        <!-- docs -->
        <div id="kc-form">
            <#assign noAuthBox>
            <div id="error-box">
                <p>Spiacenti, nessun metodo di autenticazione attualmente disponibile.</p>
            </div>
        </#assign>
            <#if social.providers??>
                <#assign spidProviders = social.providers?filter(p -> p.alias?lower_case?starts_with("spid"))>
                <#assign cieProviders = social.providers?filter(p -> p.alias?lower_case?starts_with("cie"))>
                <#if spidProviders?size gt 0 || cieProviders?size gt 0>
                    <div class="spid-title">Accedi all'area riservata con:</div>
                    <ul class="tab-nav">
                        <#assign emptyLi>
                        <li class="tab-link empty"></li>
                    </#assign>
                        <#if spidProviders?size gt 0>
                            <li class="tab-link tab-auth-method" onclick="showTab(event, 'spid-tab')">
                                <a href="#spid-tab" aria-controls="spid-tab" aria-expanded="false"><i class="fas fa-user-circle mr-2"></i>SPID</a>
                            </li>
                        <#else>
                            ${emptyLi}
                        </#if>
                        <#if cieProviders?size gt 0>
                            <li class="tab-link tab-auth-method" onclick="showTab(event, 'cie-tab')">
                                <a href="#cie-tab" aria-controls="cie-tab" aria-expanded="false"><i class="fas fa-address-card mr-2"></i>CIE</a>
                            </li>
                        <#else>
                            ${emptyLi}
                        </#if>
                    </ul>
                    <!-- SPID -->
                    <#if spidProviders?size gt 0>
                        <div id="spid-tab" class="tab-content">
                            <div class="spid-info">
                                SPID, il <b>Sistema Pubblico di Identit&agrave; Digitale</b>, &egrave; il sistema di accesso che consente di utilizzare, con un&#39;identit&agrave; digitale unica, i servizi online della Pubblica Amministrazione e dei privati accreditati.
                                <br/>
                                Se sei gi&agrave; in possesso di un&#39;identit&agrave; digitale, accedi con le credenziali del tuo gestore.
                                <br/>
                                Se non hai ancora un&#39;identit&agrave; digitale, richiedila ad uno dei gestori.
                            </div>
                            <div class="spid-action-box">
                                <div class="spid-info-links">
                                    <span class="spid-info-link"><a href="https://www.spid.gov.it">Maggiori informazioni</a></span>
                                    <span class="spid-info-link"><a href="https://www.spid.gov.it/richiedi-spid">Non hai SPID?</a></span>
                                    <span class="spid-info-link"><a href="https://www.spid.gov.it/serve-aiuto">Serve aiuto?</a></span>
                                </div>
                                <div class="spid-idp-button-box">
                                    <a id="spid-idp" href="#" class="italia-it-button italia-it-button-size-m button-spid" spid-idp-button="#spid-idp-button-medium-get" aria-haspopup="true" aria-expanded="false">
                                        <span class="italia-it-button-icon"><img src="${url.resourcesPath}/img/spid-ico-circle-bb.svg" onerror="this.src='img/spid-ico-circle-bb.png'; this.onerror=null;" alt="" /></span>
                                        <span class="italia-it-button-text">Entra con SPID</span>
                                    </a>
                                    <div id="spid-idp-button-medium-get" class="spid-idp-button spid-idp-button-tip spid-idp-button-relative">
                                        <ul id="spid-idp-list-medium-root-get" class="spid-idp-button-menu" aria-labelledby="spid-idp">

                                            <#assign sortedSpidProviders = spidProviders?sort_by("alias")>
                                            <#list sortedSpidProviders as provider>
                                                <#assign idpAlias = provider.alias?lower_case>
                                                <#assign idpName = provider.displayName>
                                                <#assign idpUrl = provider.loginUrl>

                                                <#assign idpLogos = {
                                                "spid-aruba": "spid-idp-arubaid",
                                                "spid-teamsystem": "spid-idp-teamsystemid",
                                                "spid-etnahitech": "spid-idp-etnaid",
                                                "spid-sielte": "spid-idp-sielteid",
                                                "spid-infocert": "spid-idp-infocertid",
                                                "spid-infocamere": "spid-idp-infocamereid",
                                                "spid-intesi-group": "spid-idp-intesigroupspid",
                                                "spid-lepida": "spid-idp-lepidaid",
                                                "spid-namirial": "spid-idp-namirialid",
                                                "spid-poste": "spid-idp-posteid",
                                                "spid-register.it": "spid-idp-spiditalia",
                                                "spid-tim": "spid-idp-timid",
                                                "spid-spidtestidp": "spid-idp-test",
                                                "spid-spid-saml-check": "spid-idp-spid-saml-check",
                                                "spid-validator": "spid-idp-validator",
                                                "spid-demo": "spid-idp-demo",
                                                "spid-spid-saml-check-demo": "spid-idp-local-demo"
                                                } />

                                                <!--#assign idpLogo = idpLogos[idpAlias]!-->
                                                <#assign idpLogo = idpLogos[idpAlias]?default("spid-logo-c-lb")>


                                                <li class="spid-idp-button-link" id="${idpAlias}" data-idp="${idpAlias}">
                                            <a href="${idpUrl}">
                                            <span class="spid-sr-only">${idpName}</span>
                                            <img src="${url.resourcesPath}/img/${idpLogo}.svg" onerror="this.src='${url.resourcesPath}/img/${idpLogo}.png'; this.onerror=null;" alt="${idpName}" />
                                            </a>
                                            </li>
                                            </#list>
                                        </ul>
                                    </div>
                                </div>
                            </div>
                            <div class="spid-logo"><img src="${url.resourcesPath}/img/spid-agid-logo-lb.png" alt="" /></div>
                        </div>
                    </#if>
                    <!-- ENF OF SPID -->
                    <!-- CIE -->
                    <#if cieProviders?size gt 0>
                        <div id="cie-tab" class="tab-content">
                            <div class="spid-info">
                                La <b>Carta di Identit&agrave; Elettronica (CIE)</b> &egrave; il documento personale che attesta l&#39;identit&agrave; del cittadino.
                                <br/>
                                Dotata di microprocessore, oltre a comprovare l&#39;identit&agrave; personale, permette l&#39;accesso ai servizi digitali della Pubblica Amministrazione.
                            </div>

                            <#assign sortedCieProviders = cieProviders?sort_by("alias")>
                            <#list sortedCieProviders as provider>
                                <#assign idpAlias = provider.alias?lower_case>
                                <#assign idpName = provider.displayName>
                                <#assign idpUrl = provider.loginUrl>
                                <div class="cie-idp-button-box">
                                    <a href="${idpUrl}" class="italia-it-button italia-it-button-size-m button-spid" data-cie-provider-alias="${idpAlias}" data-cie-provider-name="${idpName}" aria-haspopup="false" aria-label="Entra con CIE">
                                        <span class="italia-it-button-icon"><img src="${url.resourcesPath}/img/Logo_CIE_ID.svg" onerror="this.src='${url.resourcesPath}/img/cie_ico.png'; this.onerror=null;" alt="" /></span>
                                        <span class="italia-it-button-text">
                                            <#if idpAlias?starts_with("cieid-saml")>
                                                Entra con CIE
                                            <#else>
                                                ${idpName}
                                            </#if>
                                        </span>
                                    </a>
                                </div>
                            </#list>
                        </div>
                    </#if>
                    <!--END OF CIE -->
                    <script src="${url.resourcesPath}/js/jquery.min.js"></script>
                    <script src="${url.resourcesPath}/js/spid-sp-access-button.min.js"></script>
                    <script>
                        // Default open tab
                        var firstTabLink = document.querySelector(".tab-auth-method");
                        var firstTabContent = document.querySelector(".tab-content");
                        if (firstTabLink && firstTabContent) {
                        firstTabLink.classList.add("active");
                        firstTabContent.classList.add("active");
                        setTabAriaExpanded(firstTabLink, "true");
                        }

                        // Event listener for spid btn aria attr
                        // following spid-sp-access-button-min.js EventListener
                        var spidBtn = document.getElementById("spid-idp");
                        if (spidBtn) {
                        spidBtn.addEventListener("click", function () {
                            if (spidBtn.classList.contains("spid-idp-button-open")) {
                            spidBtn.setAttribute("aria-expanded", "false");
                            } else {
                            spidBtn.setAttribute("aria-expanded", "true");
                            }
                        });
                        }

                        function showTab(event, tabName) {
                        event.preventDefault();
                        var i, tabContent, tabLink;
                        tabContent = document.getElementsByClassName("tab-content");
                        for (i = 0; i < tabContent.length; i++) {
                            tabContent[i].classList.remove("active");
                        }
                        tabLink = document.getElementsByClassName("tab-link");
                        for (i = 0; i < tabLink.length; i++) {
                            tabLink[i].classList.remove("active");
                            setTabAriaExpanded(tabLink[i], "false");
                        }
                        document.getElementById(tabName).classList.add("active");
                        event.currentTarget.classList.add("active");
                        setTabAriaExpanded(event.currentTarget, "true");
                        }

                        function setTabAriaExpanded(el, bool) {
                        el.childNodes.forEach(function (node) {
                            if (node.nodeName === "A") {
                            if (node.getAttribute("aria-expanded")) {
                                node.setAttribute("aria-expanded", bool.toString());
                            }
                            }
                        });
                        }
                    </script>
                <#else>
                    <!-- No SPID / CIE providers found -->
                    ${noAuthBox}
                </#if> <!-- END IF SPID/CIE PROVIDERS EXIST -->
            <#else>
                <!-- No social providers found -->
                ${noAuthBox}
            </#if> <!-- ENF IF SOCIALPROVIDERS -->
        </div>
    </#if>

</@layout.registrationLayout>

