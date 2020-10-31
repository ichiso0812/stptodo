<template>
    <a @click.prevent="sign_out" class="lol" href="#">Sign out</a>
</template>

<script >
    export default {
        name: "Header",
        created() {
            this.signedIn()
        },
        methods: {
            setError(error, text){
                this.error = (error.response && error.response.data && error.response.data.error) || text
            },
            signedIn(){
                return localStorage.signedIn
            },
            sign_out(){
                this.$http.secured.delete("/signin")
                    .then(response => {
                        delete localStorage.csrf
                        delete localStorage.signedIn
                        this.$router.replace("/")
                    })
                    .catch(error=>this.setError(error, "Something went wrong"))
            }
        }
    }
</script>

<style lang="sass" scoped>
/* NEW_PROJECT: pour uriliser sass, j'ai passé sass-loader en version 7 dans package.json*/
.lol
    color: red
    font-size: 50px
    

</style>    