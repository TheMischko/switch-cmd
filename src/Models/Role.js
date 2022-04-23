import {Model} from "objection";

export default class extends Model {
    static get tableName() {
        return 'role'
    }

    static get idColumn() {
        return 'id'
    }

    static get jsonSchema() {
        return {
            type: 'object',
            properties: {
                id: {type: 'integer'},
                name: {type: 'string'}
            }
        }
    }
}