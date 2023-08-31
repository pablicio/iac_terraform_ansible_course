<template>
  <div>
    <div class="container">
      <div class="row">
        <div class="col-4">
          <div class="logo">
            <img src="https://segurolight.com.br/LogoParceiras/logo-youse.png" alt="FCC Logo" />
          </div>
          <DxTreeView id="treeView" :data-source="products" display-expr="name" item-template="product-template"
            :search-enabled="true" search-mode="contains" selectionMode="single" :select-by-click="true"
            @item-selection-changed="selectProduct">

            <template #product-template="product">
              {{ product.data.name }}
            </template>
          </DxTreeView>

        </div>
        <div class="col-8">
          <!-- <div id="content"></div> -->

          <div id="product-details" v-if="currentProduct">
            <div class="price">{{ currentProduct.name }}</div>
            <img :src="'http://localhost:8080' + currentProduct.path">
            

          </div>
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
      products: {},
      currentProduct: this.products,
      mdContent: ''
    }
  },
  mounted() {
    fetch("http://localhost:8080/map_folder.json")
      .then(response => response.json())
      .then(data => (this.products = data));

    fetch("http://localhost:8080/home.md")
      .then(response => response.text())
      .then((mdText) => {
        document.getElementById("content").innerHTML = md.render(mdText);
      })
  },
  methods: {
    selectProduct(e) {
      this.currentProduct = e.itemData;
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
  /* height: 500px; */

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
}

.logo img {
  width: 203px;
}

.container{
  margin-top: 6px;
  margin-left: 4px;
}
</style>
