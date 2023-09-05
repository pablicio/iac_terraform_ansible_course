<template>
  <div>
    <div id="swagger-ui"></div>
  </div>
</template>

<script>
import '@/assets/swagger/swagger-ui.css'
import '@/assets/swagger/themes/3.x/theme-material.css'
import SwaggerUIBundle from '@/assets/swagger/swagger-ui-bundle.js'
import SwaggerUIStandalonePreset from '@/assets/swagger/swagger-ui-standalone-preset.js'

export default {
  props: ['collection'],
  mounted() {
    const ui = SwaggerUIBundle({
      url: "https://raw.githubusercontent.com/swagger-api/swagger-samples/master/java/inflector-dropwizard/src/main/swagger/swagger.yaml",
      dom_id: '#swagger-ui',
      presets: [
        SwaggerUIBundle.presets.apis,
        SwaggerUIStandalonePreset
      ]
    })

    window.ui = ui
  }
}
</script>