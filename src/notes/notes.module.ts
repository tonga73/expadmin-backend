import { Module } from '@nestjs/common';
import { NotesService } from './notes.service';
import { UsersService } from '../users/users.service';
import { NotesController } from './notes.controller';

import { PrismaService } from '../prisma.service';

@Module({
  controllers: [NotesController],
  providers: [NotesService, PrismaService,UsersService],
  exports: [NotesService],
})
export class NotesModule {}
