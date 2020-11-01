<template>
    <a @click.prevent="sign_out" href="#">Sign out</a>
</template>

<script lang="coffee">
export default
    name: "Header",
    created: -> this.signedIn,
    methods:
        setError: (error, text) -> this.error = (error.response && error.response.data && error.response.data.error) || text
        signedIn: -> return localStorage.signedIn
        sign_out: -> 
            @$http.secured.delete("/signin")
            .then((response) -> 
                delete localStorage.csrf
                delete localStorage.signedIn
                @$router.replace("/"))
            .catch((error) -> this.setError(error, "Something went wrong"))
            
</script>

<style lang="sass" scoped>
</style>    