<template>
  <div>
    <div class="container">
      <div class="row">
        <div class="col-3 sidebar">
          <div class="logo">
            <img src="https://segurolight.com.br/LogoParceiras/logo-youse.png" alt="FCC Logo" />
          </div>

          <DxTreeView id="treeView" :data-source="items" display-expr="name" item-template="product-template"
            :search-enabled="true" search-mode="contains" selectionMode="single" :select-by-click="false"
            @item-click="selectProduct">

            <template #product-template="product">
              {{ product.data.name }}
            </template>
          </DxTreeView>
        </div>

        <div class="col-9 content">
          <div id="md-content"></div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import DxTreeView from 'devextreme-vue/tree-view';
var MarkdownIt = require('markdown-it'),
  md = new MarkdownIt();

export default {
  components: {
    DxTreeView
  },
  data() {
    return {
      items: {},
      currentItem: this.items,
      mdContent: ''
    }
  },
  mounted() {


    fetch("http://localhost:8080/map_folder.json")
      .then(response => response.json())
      .then(data => {
        this.items = data
        this.getMarkdowFile(data[0])
      });
  },
  methods: {
    selectProduct(e) {
      this.currentItem = e.itemData;
      this.getMarkdowFile(this.currentItem)
    },
    getMarkdowFile(currentItem) {
      document.getElementById("md-content").innerHTML = ''
      fetch(`http://localhost:8080${currentItem.path}/${currentItem.md_slug}`)
        .then(response => response.text())
        .then((mdText) => {
          document.getElementById("md-content").innerHTML = md.render(mdText);
        })
    }
  }
}
</script>

<style>
#treeView,
#product-details {
  display: inline-block;
  width: 300px;
}

#markdown-details {
  vertical-align: top;
  width: 400px;
  height: 420px;
  margin-left: 20px;
}

#product-details {
  vertical-align: top;
  width: 400px;
  height: 420px;
  margin-left: 20px;
}

#product-details>img {
  border: none;
}

#product-details>.name {
  text-align: center;
  font-size: 20px;
}

#product-details>.price {
  text-align: center;
  font-size: 24px;
}

.logo {
  height: 60px;
  margin-top: 17px;
  margin-bottom: 17px;
}

.logo img {
  width: 203px;
  margin-left: 47px;
}

.container {
  margin-top: 6px;
  margin-left: 4px;
}

.sidebar {
  position: fixed;
  top: 0px;
  left: 0px;
}

.content {
  position: absolute;
  right: 0px;
}

/* Serve pra delimitar a altura das imagens que tiverem o alt descrito */
img[alt="small"] {
  max-height: 260px;
}

img[alt="medium"] {
  max-height: 460px;
}

img[alt="large"] {
  max-height: 660px;
}
</style>
