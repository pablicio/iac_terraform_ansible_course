<template>
  <div>
    <div id="swagger-ui"></div>
  </div>
</template>

<script>
import SwaggerUIBundle from '@/assets/swagger/swagger-ui-bundle.js'
import SwaggerUIStandalonePreset from '@/assets/swagger/swagger-ui-standalone-preset.js'
import '@/assets/swagger/swagger-ui.css'

export default {
  props: ['collection'],
  mounted() {
    const ui = SwaggerUIBundle({
      url: "https://petstore.swagger.io/v2/swagger.json",
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