import {Model} from "objection";

export default class extends Model {
    static get tableName() {
        return 'user';
    }

    static get idColumn() {
        return 'id';
    }

    static get jsonSchema() {
        return {
            type: 'object',
            properties: {
                id: {type: 'integer'},
                username: {type: 'string'},
                email: {type: 'string'},
                password: {type: 'string'},
            }
        }
    }

    static get relationMappings() {
        return {}
    }
}