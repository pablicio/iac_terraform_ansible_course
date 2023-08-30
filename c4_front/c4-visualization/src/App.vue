<template>
  <v-app>
    <v-navigation-drawer app floating permanent v-model="localDrawer">
      <v-list nav dense>
        <v-list-item>
          <v-list-item-icon>
            <v-icon>mdi-magnify</v-icon>
          </v-list-item-icon>
          <v-list-item-content>
            <v-text-field v-model="search" dense label="Szukaj w menu" type="text" class="pb-0 mb-0"></v-text-field>
          </v-list-item-content>
        </v-list-item>
        <v-divider class="pt-0 pb-2"></v-divider>
        <v-list-group v-for="item in computedItems" :key="item.title" v-model="item.active" :prepend-icon="item.icon"
          no-action color="primary">
          <template v-slot:activator>
            <v-list-item-content>
              <v-list-item-title>{{ item.title }}</v-list-item-title>
            </v-list-item-content>
          </template>

          <v-list-item v-for="child in filterSubItems(filterSubItemsByPermissions(item.items))" :key="child.title" dense
            link>
            <v-list-item-content>
              <v-list-item-title>{{ child.title }}</v-list-item-title>
            </v-list-item-content>
          </v-list-item>
        </v-list-group>
      </v-list>
      <template v-slot:append>
        <v-divider class="pt-0"></v-divider>
        <v-list-item link>
          <v-list-item-icon>
            <v-icon>mdi-logout</v-icon>
          </v-list-item-icon>
          <v-list-item-content>
            <v-list-item-title>Wyloguj</v-list-item-title>
          </v-list-item-content>
        </v-list-item>
      </template>
    </v-navigation-drawer>

    <!-- <v-app-bar :clipped-left="$vuetify.breakpoint.lgAndUp" app color="blue">
    </v-app-bar> -->

    <v-main>
      <v-container>
        <img src="http://localhost:8080/claim-service/about/test_1.png" alt="" height="500">
        <router-view />
      </v-container>
    </v-main>
  </v-app>
</template>

<script>

export default {
  name: 'App',

  data() {
    return {
      localDrawer: true,
      menu_items_list: [
        {
          title: "Aplikacja",
          icon: "mdi-application",
          items: [
            {
              title: "Konta SMTP",
              link: "/smtpaccounts",
              permissionGroup: "smtp_smtp_account"
            }
          ]
        },
        {
          title: "Słowniki",
          icon: "mdi-book-open-variant",
          items: [
            {
              title: "Piony firmy",
              link: "/dictionary-companyhighdepartment",
              permissionGroup: "dictionary_company_high_department"
            },
            {
              title: "Działy firmy",
              link: "/dictionary-companydepartment",
              permissionGroup: "dictionary_company_department"
            },
            {
              title: "Waluty",
              link: "/dictionary-currency",
              permissionGroup: "dictionary_currency"
            },
            {
              title: "Kraje",
              link: "/dictionary-country",
              permissionGroup: "dictionary_country"
            },
            {
              title: "Typy rabatów enduser-a",
              link: "/dictionary-enduserdiscounttype",
              permissionGroup: "dictionary_end_user_discount_type"
            },
            {
              title: "Grupy enduserów",
              link: "/dictionary-endusergroup",
              permissionGroup: "dictionary_end_user_group"
            },
            {
              title: "Kolory",
              link: "/dictionary-colour",
              permissionGroup: "dictionary_colour"
            },
            {
              title: "Kody pocztowe",
              link: "/dictionary-postalcode",
              permissionGroup: "dictionary_postal_code"
            },
            {
              title: "Typy licencji",
              link: "/dictionary-licensetype",
              permissionGroup: "dictionary_license_type"
            }
          ]
        },
        {
          title: "Użytkownicy",
          icon: "mdi-account-group",
          items: [
            {
              title: "Lista użytkowników",
              link: "/user-user",
              permissionGroup: "user_user"
            },
            {
              title: "Grupy użytkowników",
              link: "/user-group",
              permissionGroup: "user_grup"
            },
            {
              title: "Lista operatorów",
              link: "/user-operator",
              permissionGroup: "user_operator"
            },
            {
              title: "Grupy operatorów",
              link: "/user-operatorgroup",
              permissionGroup: "user_operator_group"
            }
          ]
        },
        {
          title: "Uprawnienia",
          icon: "mdi-tune",
          items: [
            {
              title: "Uprawnienia",
              link: "/permission-permission",
              permissionGroup: "permission_permission"
            },
            {
              title: "Grupy uprawnień",
              link: "/permission-permissiongroup",
              permissionGroup: "permission_permission_group"
            },
            {
              title: "Role",
              link: "/permission-role",
              permissionGroup: "permission_role"
            }
          ]
        },
        {
          title: "Produkty",
          icon: "mdi-cube-outline",
          items: [
            {
              title: "Producenci",
              link: "/product-manufacturer",
              permissionGroup: "product_manufacturer"
            },
            {
              title: "Kategorie produktów",
              link: "/product-category",
              permissionGroup: "product_category"
            },
            {
              title: "Produkty główne",
              link: "/product-mainproduct",
              permissionGroup: "product_main_product"
            },
            {
              title: "Produkty gł. - Parametry (sł)",
              link: "/product-mainproductparameter",
              permissionGroup: "product_parameter"
            },
            {
              title: "Produkty gł. - Parametry",
              link: "/product-mainproducthasparameter",
              permissionGroup: "product_main_product_has_parameter"
            },
            {
              title: "Produkty gł. - Grupy parametrów",
              link: "/product-mainproductparametergroup",
              permissionGroup: "product_parameter_group"
            },
            {
              title: "Produkty gł. - Operacje",
              link: "/product-mainproducthasoperation",
              permissionGroup: "product_main_product_has_operation"
            }
          ]
        },

        {
          title: "Klienci",
          icon: "mdi-account-circle",
          items: [
            {
              title: "Lista klientów",
              link: "/client-client",
              permissionGroup: "client_client"
            }
          ]
        },
        {
          title: "Artykuły",
          icon: "mdi-file-code",
          items: [
            {
              title: "Artykuły",
              link: "/article-article",
              permissionGroup: "article_article"
            },
            {
              title: "Kategorie artykułu",
              link: "/article-articlecategory",
              permissionGroup: "article_article_category"
            },
            {
              title: "Powiązania artykułów",
              link: "/article-articleassociation",
              permissionGroup: "article_article_association"
            }
          ]
        },
        {
          title: "Szablony",
          icon: "mdi-checkbox-multiple-blank-outline",
          items: [
            {
              title: "Kategorie szablonów dokumentów",
              link: "/documenttemplate-category",
              permissionGroup: "document_template_document_template_category"
            },
            {
              title: "Szablony dokumentów",
              link: "/documenttemplate-list",
              permissionGroup: "document_template_document_template"
            },
            {
              title: "Kategorie szablonów e-mail",
              link: "/emailtemplate-category",
              permissionGroup: "email_template_email_template_category"
            },
            {
              title: "Konteksty użycia szablonów e-mail",
              link: "/emailtemplateusage-context",
              permissionGroup: "email_template_email_template_usage_context"
            },
            {
              title: "Szablony email",
              link: "/emailtemplate-list",
              permissionGroup: "email_template_document_template"
            }
          ]
        },
        {
          title: "RODO",
          icon: "mdi-security",
          items: [
            {
              title: "Rejestr zbiorów danych",
              link: "/rodo-dataset",
              permissionGroup: "dataset_dataset"
            },
            {
              title: "Rejestr naruszeń - Klasyfikacje",
              link: "/rodo-infringementclassification",
              permissionGroup: "infringement_classification"
            },
            {
              title: "Rejestr incydentów",
              link: "/rodo-infringement",
              permissionGroup: "infringement_infringement"
            },
            {
              title: "Rejestr czynnośći przetwarzania",
              link: "/rodo-processingactivity",
              permissionGroup: "processing_activity_processing_activity"
            },
            {
              title: "Rejestr kategorii czynnośći przetwarzania",
              link: "/rodo-processingactivitycategory",
              permissionGroup:
                "processing_activity_category_processing_activity"
            }
          ]
        }
      ],
      menu_items_with_permissions: [], //
      search: "",
      userPermissionGroup: [
        "dictionary_company_high_department",
        "dictionary_company_department",
        "user_user"
      ]
    };
  },
  mounted() {
    this.initialize();
  },
  methods: {
    initialize() {
      this.menu_items_list = this.menu_items_list.filter((row) => {
        return this.filterSubItemsByPermissions(row.items).length > 0;
      });
    },

    filterSubItems(subItems) {
      let searchString = this.search.toLowerCase();
      if (!searchString) {
        return subItems;
      }
      return subItems.filter((row) => {
        return row.title.toLowerCase().includes(searchString);
      });
    },

    filterSubItemsByPermissions(subItems) {
      return subItems.filter((row) => {
        if (
          this.userPermissionGroup.some((role) => role === row.permissionGroup)
        ) {
          return row.permissionGroup.toLowerCase();
        }
      });
    }
  },
  computed: {
    computedItems() {
      let searchString = this.search.toLowerCase();
      if (!searchString) {
        return this.menu_items_list;
      }
      return this.menu_items_list.filter((row) => {
        return (
          row.title.toLowerCase().includes(searchString) ||
          this.filterSubItems(row.items).length > 0
        );
      });
    }
  }
};
</script>
