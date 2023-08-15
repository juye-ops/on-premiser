export const GetProjectList = async () => {
    try {
        const response = await fetch("/api/project/list/", {
            method: "GET",
            headers: {
                "Content-Type": "application/json",
            },
        });

        const result = response.json();

        return result;
    } catch (e) {
        console.log(e);
    }
}

export const GenerateProject = async ({ user_name, name, description }) => {
    try {
        const response = await fetch("/api/project/create/", {
            method: "POST",
            headers: {
                "Content-Type": "application/json",
            },
            body: JSON.stringify({
                user_name,
                name,
                description,
            }),
        });

        const result = response.json();

        return result;
    } catch (e) {
        console.log(e);
    }
}