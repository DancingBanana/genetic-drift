define ['cs!models/StaticEntity'], (StaticEntity) ->

    class DoorEntity extends StaticEntity

        template:
            name: 'door'
            height: 3
            width: .2
            color: 'red'
            fixedRotation: true
            density: 100 # Make it impossible to move

    return DoorEntity
