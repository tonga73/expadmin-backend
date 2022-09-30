import { Module } from '@nestjs/common';
import { PrismaService } from './prisma.service';

import { AppController } from './app.controller';
import { AppService } from './app.service';

import { UsersModule } from './users/users.module';
import { RecordsModule } from './records/records.module';
import { NotesModule } from './notes/notes.module';
import { CourtsModule } from './courts/courts.module';
import { DistrictsModule } from './districts/districts.module';

@Module({
  imports: [
    UsersModule,
    RecordsModule,
    NotesModule,
    CourtsModule,
    DistrictsModule,
  ],
  controllers: [AppController],
  providers: [AppService, PrismaService],
})
export class AppModule {}
