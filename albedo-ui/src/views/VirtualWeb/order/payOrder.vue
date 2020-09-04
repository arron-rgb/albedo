<template>
<div>
  <!--    步骤条-->
  <step-line></step-line>

  <div class="container">
  </div>
</div>
</template>

<script>
import stepLine from "@/components/VirtualWeb/stepLine";
export default {
  name: "payOrder",
  components : {
    stepLine,
  },
}
</script>

<style scoped>
.container{
  width: 1200px;
  margin: auto;
  padding: 30px 0;
}
</style>
