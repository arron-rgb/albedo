<template>
  <div>
    <!--    步骤条-->
    <step-line></step-line>
    <div>
      <router-view></router-view>
    </div>
  </div>
</template>

<script>
import stepLine from "@/components/VirtualWeb/stepLine";
export default {
  name: "order",
  components : {
    stepLine,
  },
}
</script>

<style scoped>

</style>
